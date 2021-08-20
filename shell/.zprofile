export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR=vim
if command -v nvim >/dev/null 2>&1; then
    alias vim=nvim
    export EDITOR=nvim
fi

export ZDOTDIR="$HOME"

export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"

export PAGER=less
export LESS='-R'

export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1

# misc
export GOPATH="$HOME/.go"
export LEDGER_FILE="$HOME/.ledger/all.journal"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export IPYTHONDIR="$HOME/.ipython"
export PIP_REQUIRE_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export VOLTA_HOME="$HOME/.volta"
export PYENV_ROOT="$HOME/.pyenv"

export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

export PATH="$HOME/bin:$PATH"
export PATH="/opt/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
