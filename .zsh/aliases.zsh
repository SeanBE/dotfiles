alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vi='vimx'
alias vim='vimx'

alias dokcer='docker'
alias docker-rmi-dangling='docker rmi $* $(docker images -q -f dangling=true)'

alias pip='python -m pip'
alias ssh='TERM=xterm ssh'
alias za='zathura --fork'
alias explore='fzf --preview "bat {-1} --color=always"'

alias newsboat='docker run --rm -it --name newsboat -e XDG_CONFIG_HOME=/home/builder -v /home/sean/.config/newsboat:/home/builder/.newsboat lsemenenko/newsboat:9813f91'

# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
if (( $+commands[exa] )); then
  alias lss='/bin/ls'
  alias ls='exa'
  alias la='exa -la --sort newest'
fi

if (( $+commands[htop] )); then
  alias top='htop'
fi

