#zmodload zsh/zprof

# TODO: where should this go??
fpath+=$HOME/.zsh/functions

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export DELTA_FEATURES="lightmode"
export PATH=/usr/local/go/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/opt/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# TODO: move elsewhere

export FZF_DEFAULT_OPTS="--height 20% --color=16"
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --ignore-global --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

source $HOME/.zsh/plugins.zsh

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh

source $HOME/.zsh/functions.zsh

umask 0002  # setting umask here since its being set to 0077 somewhere...
setopt noflowcontrol; stty -ixon
#zprof
