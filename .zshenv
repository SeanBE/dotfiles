ZDOTDIR=$HOME
EDITOR=vim
if command -v nvim >/dev/null 2>&1; then
      alias vim=nvim
        EDITOR=nvim
fi

PAGER=less
LESS='-R'
