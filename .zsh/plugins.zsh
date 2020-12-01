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
    OMZP::aws/aws.plugin.zsh \
    OMZP::ssh-agent/ssh-agent.plugin.zsh \
    "https://github.com/agkozak/zsh-z/blob/master/zsh-z.plugin.zsh"

zinit ice as"completion"
zinit snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker'

zinit ice as"completion"
zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

# need to clone (releases only includes binary)
zinit ice as"program" pick"$ZPFX/bin/fzf" \
  atclone"mkdir -p $ZPFX/{bin,man/man1}; cp bin/fzf $ZPFX/bin/; \
  cp man/man1/fzf.1 $ZPFX/man/man1/fzf.1; cp bin/fzf-tmux $ZPFX/bin; \
  cp shell/completion.zsh _fzf_completion; cp shell/key-bindings.zsh key-bindings.zsh" \
  atpull"%atclone" nocompile"" make"!PREFIX=$ZPFX install"
zinit light junegunn/fzf

type fzf &> /dev/null && {
    export FZF_DEFAULT_OPTS="--height 20% --color=16"
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
}

export NVM_LAZY_LOAD=true
export NVM_DIR="$HOME/.config/nvm"
export NVM_SYMLINK_CURRENT=true # nvm use should make a symlink
zinit light lukechilds/zsh-nvm
## https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"

# or PYENV_ROOT="${HOME}/.pyenv"
zinit ice atclone'./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    as"program" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!"
zinit light pyenv/pyenv

zinit ice cloneonly nocompile nocompletions \
    atclone"mkdir -p $PYENV_ROOT/plugins;
    ln -sf ${ZINIT[PLUGINS_DIR]}/pyenv---pyenv-virtualenv $PYENV_ROOT/plugins/pyenv-virtualenv"
zinit light pyenv/pyenv-virtualenv

zplugin ice as"completion" atclone"python ./get-poetry.py; \
    $HOME/.poetry/bin/poetry completions zsh > _poetry" \
    atpull"%atclone" atload'PATH+=:$HOME/.poetry/bin'
zplugin light python-poetry/poetry

zinit light zsh-users/zsh-history-substring-search

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
zinit ice wait"0a" lucid atload"_zsh_autosuggest_start" 
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit; compinit
zinit cdreplay -q
