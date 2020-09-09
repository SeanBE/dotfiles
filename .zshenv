# XDG 
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

# Editor
export EDITOR=vim
if command -v nvim >/dev/null 2>&1; then
    alias vim=nvim
    export EDITOR=nvim
fi

# ZSH
export ZDOTDIR="$HOME"
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"

# Misc
export PAGER=less
export LESS='-R'

export CLUTTER_BACKEND=wayland
export GDK_BACKEND=wayland
export LEDGER_FILE="$HOME/.ledger/all.journal"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

## Golang
# TODO: move to installation
export GOPATH="$HOME/.go"

##Python 
export IPYTHONDIR="$HOME/.ipython"
export PIP_REQUIRE_VIRTUALENV=true
