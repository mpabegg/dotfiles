# https://wiki.archlinux.org/title/XDG_Base_Directory#Specification
# Where user-specific data files should be written (analogous to /usr/share).
export XDG_DATA_HOME=$HOME/.local/share
# Where user-specific non-essential (cached) data should be written (analogous to /var/cache)
export XDG_CONFIG_HOME=$HOME/.config
# Where user-specific non-essential (cached) data should be written (analogous to /var/cache).
export XDG_CACHE_HOME=$HOME/.cache

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_CACHE_HOME/.zhistory

export MYDOTDIR=$HOME/.dotfiles/
# This prevents Apple Terminal from cluttering the .config/zsh folder with .zsh_sessions
export SHELL_SESSIONS_DISABLE=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=UTF-8

