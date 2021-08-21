# force no ssh-keys loading at startup
zstyle :omz:plugins:ssh-agent identities ""
zstyle :omz:plugins:ssh-agent lifetime 4h

# from https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

source ~/.zsh/repos/ohmyzsh/lib/history.zsh
source ~/.zsh/repos/ohmyzsh/lib/clipboard.zsh
source ~/.zsh/repos/ohmyzsh/lib/completion.zsh
source ~/.zsh/repos/ohmyzsh/lib/correction.zsh
source ~/.zsh/repos/ohmyzsh/lib/termsupport.zsh
source ~/.zsh/repos/ohmyzsh/lib/key-bindings.zsh
source ~/.zsh/repos/ohmyzsh/lib/directories.zsh

# TODO: switch to https://github.com/ajeetdsouza/zoxide
source ~/.zsh/repos/z/zsh-z.plugin.zsh
source ~/.zsh/repos/ohmyzsh/plugins/git/git.plugin.zsh
source ~/.zsh/repos/ohmyzsh/plugins/ssh-agent/ssh-agent.plugin.zsh

source ~/.fzf.zsh

function pyenv() {
    # lazy load pyenv
    unset -f pyenv
    eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv virtualenv-init - zsh)"
    # virtualenv long abandoned unfortunately
    # by running this again..virtualenv seems to work..
    eval "$(pyenv init --path --no-rehash)"
    pyenv $@
}

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source ~/.zsh/repos/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/repos/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
