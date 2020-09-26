alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vi='vimx'
alias vim='vimx'

alias dokcer='docker'
alias docker-rmi-dangling='docker rmi $* $(docker images -q -f dangling=true)'

alias pip='python -m pip'
alias ssh='TERM=xterm ssh'
alias za='zathura --fork'
alias explore='fzf --preview "bat {-1} --color=always"'

hledger_image="dastapov/full-fledged-hledger:latest"
run_hledger_in_docker="docker run --rm -it --user $(id -u):$(id -g) -v $HOME/.ledger:/full-fledged-hledger:z"
alias hledger="$run_hledger_in_docker $hledger_image hledger -f all.journal"
alias hledger-web="$run_hledger_in_docker -p '127.0.0.1:5000:5000' $hledger_image hledger-web -f all.journal --serve --host 0.0.0.0"
alias hledger-build="$run_hledger_in_docker $hledger_image ./export.sh --rebuild --trace"

# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
if (( $+commands[exa] )); then
  alias lss='/bin/ls'
  alias ls='exa'
  alias la='exa -la --sort newest'
fi

if (( $+commands[htop] )); then
  alias top='htop'
fi

