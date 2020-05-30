source $HOME/.zsh/theme.zsh
source $HOME/.zsh/plugins.zsh

# TODO: install + load with zinit (need to debug ctrl+r)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions

HISTSIZE=50000
SAVEHIST=50000

umask 0002  # setting umask here since its being set to 0077 somewhere...

# keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line
