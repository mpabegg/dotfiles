#!/usr/bin/env bash
set -euo pipefail

if ! command -v gum >/dev/null 2>&1; then
  echo "gum is required for this script. Install it first, then rerun."
  exit 1
fi

require_cmd() {
  command -v "$1" >/dev/null 2>&1
}

for cmd in curl rpm rpm-ostree systemctl; do
  if ! require_cmd "$cmd"; then
    echo "Required command not found: $cmd"
    exit 1
  fi
done

spin() {
  local title="$1"
  shift
  if declare -F "$1" >/dev/null 2>&1; then
    "$@"
    return 0
  fi
  if [[ -t 0 && -t 1 ]]; then
    if gum spin --title "$title" -- "$@"; then
      return 0
    fi
    warn "Spinner failed; retrying without gum."
  fi
  "$@"
}

info() {
  gum style --foreground 10 --bold "$1"
}

warn() {
  gum style --foreground 3 --bold "$1"
}

rpm_ostree_install() {
  local -a pkgs=("$@")
  local output
  set +e
  output="$(sudo rpm-ostree install "${pkgs[@]}" 2>&1)"
  status=$?
  set -e
  if [[ $status -ne 0 ]]; then
    if echo "$output" | grep -q "already requested"; then
      warn "rpm-ostree install skipped; packages already requested."
      return 0
    fi
    echo "$output" >&2
    return "$status"
  fi
  return 0
}

ensure_file_content() {
  local path="$1"
  local content="$2"
  local tmp
  tmp="$(mktemp)"
  printf "%s\n" "$content" >"$tmp"
  if sudo test -f "$path" && sudo cmp -s "$tmp" "$path"; then
    rm -f "$tmp"
    return 0
  fi
  spin "Updating $path" sudo install -m 0644 "$tmp" "$path"
  rm -f "$tmp"
}

ensure_file_from_url() {
  local path="$1"
  local url="$2"
  local tmp
  tmp="$(mktemp)"
  spin "Downloading $(basename "$path")" curl -fsSL "$url" -o "$tmp"
  if sudo test -f "$path" && sudo cmp -s "$tmp" "$path"; then
    rm -f "$tmp"
    return 0
  fi
  spin "Updating $path" sudo install -m 0644 "$tmp" "$path"
  rm -f "$tmp"
}

info "Starting first-boot setup"

if systemctl list-unit-files --type=service --no-legend | grep -q '^brew-setup\.service'; then
  if ! systemctl is-active --quiet brew-setup.service; then
    spin "Starting brew-setup.service" sudo systemctl start brew-setup.service
    warn "brew-setup.service started; a new shell session may be needed."
  else
    info "brew-setup.service already active"
  fi
else
  warn "brew-setup.service not found; skipping"
fi

ensure_file_from_url "/etc/pki/rpm-gpg/RPM-GPG-KEY-1password" "https://downloads.1password.com/linux/keys/1password.asc"

ONEPASSWORD_REPO='[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-1password'
ensure_file_content "/etc/yum.repos.d/1password.repo" "$ONEPASSWORD_REPO"

FEDORA_VERSION="$(rpm -E %fedora)"
KEYD_REPO_URL="https://copr.fedorainfracloud.org/coprs/alternateved/keyd/repo/fedora-${FEDORA_VERSION}/alternateved-keyd-fedora-${FEDORA_VERSION}.repo"
ensure_file_from_url "/etc/yum.repos.d/_copr:alternateved:keyd.repo" "$KEYD_REPO_URL"

KEYD_CONF='[ids]

*

[main]

capslock = overload(control, esc)
102nd = layer(shift)'
spin "Ensuring /etc/keyd exists" sudo install -d /etc/keyd
ensure_file_content "/etc/keyd/default.conf" "$KEYD_CONF"

missing_packages=()
for pkg in 1password 1password-cli keyd; do
  if ! rpm -q "$pkg" >/dev/null 2>&1; then
    missing_packages+=("$pkg")
  fi
done

if ((${#missing_packages[@]} > 0)); then
  if spin "Installing packages: ${missing_packages[*]}" rpm_ostree_install "${missing_packages[@]}"; then
    warn "rpm-ostree install completed; a reboot is typically required."
  fi
else
  info "Required packages already installed"
fi

if systemctl list-unit-files --type=service --no-legend | grep -q '^keyd\.service'; then
  if ! systemctl is-enabled --quiet keyd 2>/dev/null || ! systemctl is-active --quiet keyd 2>/dev/null; then
    spin "Enabling keyd" sudo systemctl enable --now keyd
  else
    info "keyd already enabled and active"
  fi
else
  warn "keyd.service not found; skipping enable"
fi

if require_cmd flatpak; then
  FLATPAK_APPS=(
    "com.ktechpit.torrhunt"
    "org.qbittorrent.qBittorrent"
    "com.vscodium.codium"
  )
  info "Select Flatpak apps to install"
  installed_flatpaks=()
  installable_flatpaks=()
  flatpak_apps_installed="$(flatpak list --app --columns=application 2>/dev/null | tail -n +2)"
  for app_id in "${FLATPAK_APPS[@]}"; do
    if printf '%s\n' "$flatpak_apps_installed" | grep -Fxq "$app_id"; then
      installed_flatpaks+=("$app_id")
    else
      installable_flatpaks+=("$app_id")
    fi
  done
  if ((${#installed_flatpaks[@]} > 0)); then
    info "Already installed: ${installed_flatpaks[*]}"
  fi
  if ((${#installable_flatpaks[@]} == 0)); then
    info "All Flatpak apps already installed"
    info "No Flatpak apps selected"
    goto_flatpak_done=1
  else
    goto_flatpak_done=0
  fi
  if [[ "$goto_flatpak_done" -ne 1 && -t 0 && -t 1 ]]; then
    GUM_INPUT_TTY="/dev/tty" GUM_OUTPUT_TTY="/dev/tty" \
      mapfile -t selected_flatpaks < <(gum choose --no-limit "${installable_flatpaks[@]}" </dev/tty || true)
    if ((${#selected_flatpaks[@]} > 0)); then
      spin "Ensuring Flathub remote" sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      for app_id in "${selected_flatpaks[@]}"; do
        spin "Installing $app_id" sudo flatpak install -y flathub "$app_id"
      done
    else
      info "No Flatpak apps selected"
    fi
  else
    if [[ "$goto_flatpak_done" -ne 1 ]]; then
      warn "No TTY detected; skipping Flatpak selection"
    fi
  fi
else
  warn "flatpak not found; skipping Flatpak installs"
fi

if require_cmd ujust; then
  info "Running ujust update (may prompt for confirmation)"
  ujust update
else
  warn "ujust not found; skipping update"
fi

info "First-boot setup complete"
