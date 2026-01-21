#!/usr/local/bin/zsh

# Use emacs keybindings
bindkey -e

# Set up completion caching
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

# Set up Homebrew environment based on OS
if [[ $OSTYPE == linux-gnu* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Set up Homebrew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit

  # Regenerate completion cache daily
  _comp_files=($XDG_CACHE_HOME/zsh/zcompdump(Nm-20))
  if (( $#_comp_files )); then
    compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
  else
    compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump"
  fi
  unset _comp_files
fi

# Add custom function directories to fpath and autoload them
fpath=($ZDOTDIR/functions/**/ $fpath)
autoload -U $ZDOTDIR/functions/**/*(.:t)

# Load zsh/complist module and set completion options
zmodload zsh/complist
_comp_options+=(globdots)

# Load colors
autoload -Uz colors && colors

# Source custom functions and initialize plugins
source "$ZDOTDIR/zsh-functions"
zsh_init_plugins

# Source all .zsh files in the adds directory
for f in $ZDOTDIR/adds/*.zsh; do
  source $f
done

# Source aliases
source "$ZDOTDIR/alias.zsh"

# Add and configure plugins
zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Set keybinding for accepting autosuggestions
bindkey '^Y' autosuggest-accept
set bell-style off

# Source asdf version manager
# source $(brew --prefix asdf)/libexec/asdf.sh

# Set environment variables
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export ARCHFLAGS="-arch $(uname -m)"

# Modify PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

if type mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

if type starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
