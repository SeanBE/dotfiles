if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…"
    command mkdir -p $HOME/.zinit
    command git clone https://github.com/zdharma/zinit $HOME/.zinit/bin
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent identities "" # force no ssh-keys loading at startup

zinit lucid for \
    OMZL::git.zsh \
    OMZL::history.zsh \
    OMZL::clipboard.zsh \
    OMZL::completion.zsh \
    OMZL::correction.zsh \
    OMZL::directories.zsh \
    OMZL::termsupport.zsh \
    OMZL::key-bindings.zsh \
    OMZL::theme-and-appearance.zsh \
    OMZP::git/git.plugin.zsh \
    OMZP::ssh-agent/ssh-agent.plugin.zsh \
    "https://github.com/agkozak/zsh-z/blob/master/zsh-z.plugin.zsh"

zinit ice as"completion"
zinit snippet OMZP::docker/_docker


# FZF
export FZF_DEFAULT_OPTS="--height 20% --color=16"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

## https://github.com/junegunn/fzf/issues/1437
zinit ice from"gh-r" as"program" 
zinit light junegunn/fzf-bin
zinit ice multisrc"shell/{key-bindings,completion}.zsh" pick""
zinit light junegunn/fzf

zinit light zsh-users/zsh-history-substring-search

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait"0a" lucid atload"_zsh_autosuggest_start" 
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit; compinit
zinit cdreplay -q
