#!/usr/local/bin/zsh
eval "$(starship init zsh)"

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit

    compinit -d "$XDG_DATA_HOME/zsh/zcompcache"
fi

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

autoload -Uz colors && colors

source "$ZDOTDIR/zsh-functions"
zsh_init_plugins

zsh_add_dir "git"

zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
bindkey '^L' autosuggest-accept
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


export ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
source $(brew --prefix asdf)/libexec/asdf.sh

export PATH="$HOME/.emacs-distros/doom/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
