# My ~/.dotfiles

.Dotfile configuration inspired by [this Hacker News thread] (https://news.ycombinator.com/item?id=11071754).

Previously used [@holman](https://github.com/holman/) topical structure ([holman's dotfiles](http://github.com/holman/dotfiles)).

## Install

Instructions not complete.
 
```sh
git clone --bare https://github.com/SeanBE/dotfiles.git $HOME/.dotfiles

# The git directory has been cloned to ~/.dotfiles . Time to bring over the goodies. 
# You might have existing files that conflict with my dotfiles.
# The following will fail with conflicts if your existing files are not removed (Use force flag -f if simply do not care).
git --work-tree=$HOME --git-dir=$HOME/.dotfiles checkout

git --work-tree=$HOME --git-dir=$HOME/.dotfiles submodule update --init --recursive

ln -s $HOME/.vim/autoload/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim

source ~/.zshrc
dot config --local status.showUntrackedFiles no

# Set up weechat with /scripts buffers.pl buffer_autoclose.py go.py iset.pl autojoin.py 
```
