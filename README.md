.dotfile configuration inspired by [this Hacker News thread](https://news.ycombinator.com/item?id=11071754).

## Install
Instructions not complete.
 
```sh
git clone --bare https://github.com/SeanBE/dotfiles.git $HOME/.dotfiles

# The git directory has been cloned to ~/.dotfiles . Time to bring over the goodies. 
# You might have existing files that conflict with my dotfiles.
# The following will fail with conflicts if your existing files are not removed (Use force flag -f if simply do not care).
git --work-tree=$HOME --git-dir=$HOME/.dotfiles checkout
git --work-tree=$HOME --git-dir=$HOME/.dotfiles submodule update --init --recursive

source ~/.zshrc
dot config --local status.showUntrackedFiles no
# Update .gitconfig.local.example with your own user credentials (and remove .example extension).

```
