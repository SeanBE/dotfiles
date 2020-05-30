zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent identities "" # force no ssh-keys loading at startup

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# common OMZ libraries
zinit snippet OMZL::git.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::correction.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# https://github.com/zdharma/zinit#zinit-wiki
zinit load zsh-users/zsh-history-substring-search
zinit load zsh-users/zsh-autosuggestions

zinit ice as"completion"
zinit snippet OMZP::docker/_docker
zinit snippet OMZP::git/git.plugin.zsh
zinit snippet OMZP::ssh-agent/ssh-agent.plugin.zsh
zinit snippet "https://github.com/agkozak/zsh-z/blob/master/zsh-z.plugin.zsh"

# comes with completions and fzf-tmux executable
#zinit pack for fzf

# TODO: https://github.com/eduarbo/dotfiles/blob/master/shell/zsh/speedup.zsh
autoload -Uz compinit; compinit
zinit cdreplay -q
