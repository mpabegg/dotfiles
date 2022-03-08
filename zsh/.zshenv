XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
ZDOTDIR=$XDG_CONFIG_HOME/zsh

# This prevents Apple Terminal from cluttering the .config/zsh folder with .zsh_sessions
SHELL_SESSIONS_DISABLE=1
