#!/usr/local/bin/zsh

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache/"
zstyle ':completion:*' menu select

if [[ $OSTYPE == linux-gnu* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(starship init zsh)"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
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

# Prepend all directories in $ZSH_DIR/functions to the fpath
fpath=($ZDOTDIR/functions/**/ $fpath)
# and autoload all files in $ZSH_DIR/functions
autoload -U $ZDOTDIR/functions/**/*(.:t)

zmodload zsh/complist
_comp_options+=(globdots)

autoload -Uz colors && colors

source "$ZDOTDIR/zsh-functions"
zsh_init_plugins

for f in $ZDOTDIR/adds/*.zsh; do
  source $f
done

zsh_add_plugin "zimfw/environment"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

bindkey '^Y' autosuggest-accept

source $(brew --prefix asdf)/libexec/asdf.sh

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export ARCHFLAGS="-arch $(uname -m)"

export PATH="$HOME/.emacs-distros/doom/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"
export PATH="$(brew --prefix mysql-client)/bin:$PATH"
export PATH="$(brew --prefix postgresql@11)/bin:$PATH"

set bell-style off
