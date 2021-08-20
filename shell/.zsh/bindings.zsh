bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line
