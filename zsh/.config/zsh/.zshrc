#!/usr/local/bin/zsh

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

eval "$(starship init zsh)"

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit

    # Shamelessly borrowed from Prezto. Regenerates the completion cache approximately daily.
    _comp_files=($XDG_CACHE_HOME/zsh/zcompdump(Nm-20))
    if (( $#_comp_files )); then
        compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
    else
        compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump"
    fi
    unset _comp_files
fi

zmodload zsh/complist
_comp_options+=(globdots)

autoload -Uz colors && colors

source "$ZDOTDIR/zsh-functions"
zsh_init_plugins

for f in $ZDOTDIR/adds/*.zsh; do
    source $f
done

zsh_add_bin "secrets"

zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
bindkey '^L' autosuggest-accept
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


export ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf
if [[ $OSTYPE == linux-gnu* ]]; then
    source /opt/asdf-vm/asdf.sh
else
    source $(brew --prefix asdf)/libexec/asdf.sh
fi

export ARCHFLAGS="-arch x86_64"
export LIBRARY_PATH="/usr/local/opt/openssl@1.1/lib:$LIBRARY_PATH"

export PATH="$HOME/.emacs-distros/doom/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"

set bell-style off
