source $HOME/.exports
source $HOME/.functions

eval $(dircolors | sed 's/ow=\([0-9]*\);[0-9]*/ow=\1;40/')

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

plugins=(git aws pip python docker docker-compose zsh-syntax-highlighting z)

source $ZSH/oh-my-zsh.sh

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
