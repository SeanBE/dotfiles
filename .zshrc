#zmodload zsh/zprof

# TODO: where should this go??
fpath+=$HOME/.zsh/functions

source $HOME/.zsh/plugins.zsh

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh

export DELTA_FEATURES=$BASE16_THEME
export PATH=/usr/local/go/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/opt/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# TODO: move elsewhere
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source $HOME/.zsh/functions.zsh

umask 0002  # setting umask here since its being set to 0077 somewhere...
setopt noflowcontrol; stty -ixon
#zprof
