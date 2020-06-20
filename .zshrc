#zmodload zsh/zprof
source $HOME/.zsh/theme.zsh
source $HOME/.zsh/plugins.zsh

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh

source $HOME/.exports
source $HOME/.functions

umask 0002  # setting umask here since its being set to 0077 somewhere...
#zprof
