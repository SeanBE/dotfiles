export EDITOR='vim'
export TERM=tmux-256color        # for common 256 color terminals (e.g. gnome-terminal)
eval $(dircolors | sed 's/ow=\([0-9]*\);[0-9]*/ow=\1;40/')

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python

export PATH=${PATH}:$HOME/.bin
export GOPATH=$HOME/dev/golang

export PGDATA=/var/lib/pgsql/data                                                          

#TODO use alternatives
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-1.b14.fc25.x86_64

export GRADLE_HOME=/opt/gradle-3.3
export PATH=${PATH}:${GRADLE_HOME}/bin

export ANDROID_HOME=~/dev/android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=${PATH}:${NPM_CONFIG_PREFIX}/bin

export TEXLIVE_HOME=/opt/texbin
export PATH=${PATH}:${TEXLIVE_HOME}

ZSH_THEME="Soliah"
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh_custom
plugins=(git pip python docker-compose zsh-syntax-highlighting z)
source $ZSH/oh-my-zsh.sh

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
