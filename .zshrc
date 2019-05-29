source $HOME/.exports
source $HOME/.functions

eval $(dircolors | sed 's/ow=\([0-9]*\);[0-9]*/ow=\1;40/')

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

plugins=(git aws pip python docker docker-compose z jsontools)

function kubectl() {
        if ! type __start_kubectl >/dev/null 2>&1; then
                source <(command kubectl completion zsh)
        fi
        command kubectl "$@"
}

source $ZSH/oh-my-zsh.sh

# TODO check this
alias mount_usb="sudo mount /dev/sdb1 /mnt/usb"

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# TODO respect .gitiginore??
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ack=ag
alias ag='ag --color-path 1\;31 --color-match 1\;32 --color'

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# figure out auto way to bring in these https://github.com/nicodebo/base16-fzf/tree/master/bash
#if _has fzf && _has ag; then
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# preview not working
export FZF_DEFAULT_OPTS="--height 40% --color=16"

# TODO export TODO file here.
echo "TODO add disk usage here."
