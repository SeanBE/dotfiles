plugins=(git gitfast python docker docker-compose z jsontools zsh-autosuggestions ssh-agent)

# ssh agent plugin
zstyle :omz:plugins:ssh-agent lifetime 4h
# Force *no* SSH-keys loaded; we want to load via AddKeysToAgent so we aren't prompted on login
zstyle :omz:plugins:ssh-agent identities ""

# disable magic functions (bracketd paste plugin)
DISABLE_MAGIC_FUNCTIONS=true

export ZSH_THEME="Soliah"
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh_custom

source $ZSH/oh-my-zsh.sh

# setting umask here since its being set to 0077 somewhere...
umask 0002

source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 20% --color=16"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Ctrl+XX to edit current cli
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line
