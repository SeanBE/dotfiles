#zmodload zsh/zprof

export DELTA_FEATURES="darkmode"
export FZF_DEFAULT_OPTS="--height 20% --color=16"
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --ignore-global --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

fpath+=$HOME/.zsh/functions

source $HOME/.zsh/plugins.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh
source $HOME/.zsh/functions.zsh

# TODO: confirm these two are still necessary
umask 0002  # setting umask here since its being set to 0077 somewhere...
setopt noflowcontrol; stty -ixon

#zprof
