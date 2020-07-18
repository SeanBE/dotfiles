export ZDOTDIR=$HOME

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_BIN_HOME=~/.local/bin

export HISTSIZE=50000
export SAVEHIST=50000

export EDITOR=vim
if command -v nvim >/dev/null 2>&1; then
    alias vim=nvim
    export EDITOR=nvim
fi

export PAGER=less
export LESS='-R'

export PIP_REQUIRE_VIRTUALENV=true

# TODO: move to installation
export GOPATH=$HOME/.go
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export NEWSBOAT_SHA=974207a
