# https://wiki.archlinux.org/title/XDG_Base_Directory#Specification
# Where user-specific data files should be written (analogous to /usr/share).
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
# Where user-specific non-essential (cached) data should be written (analogous to /var/cache)
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
# Where user-specific data files should be written (analogous to /usr/share).
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}


ZDOTDIR=$XDG_CONFIG_HOME/zsh

ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf

# This prevents Apple Terminal from cluttering the .config/zsh folder with .zsh_sessions
SHELL_SESSIONS_DISABLE=1

LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_CTYPE=UTF-8
