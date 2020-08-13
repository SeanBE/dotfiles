.dotfile configuration inspired by [this Hacker News thread](https://news.ycombinator.com/item?id=11071754).

```sh
git clone --bare https://github.com/SeanBE/dotfiles.git $HOME/.dotfiles

# The git directory has been cloned to ~/.dotfiles . Time to bring over the goodies. 
# Existing files that conflict with my dotfiles will cause the following to fail.
# Move them or use the force flag if you simply do not care.
git --work-tree=$HOME --git-dir=$HOME/.dotfiles checkout
git --work-tree=$HOME --git-dir=$HOME/.dotfiles submodule update --init --recursive

# Installs system dependencies, some language specific tools etc.
# Feel free to drop things you don't need.
./bin/install.sh

source ~/.zshrc
dot config --local status.showUntrackedFiles no

# Things to do.
# * cp .gitconfig.local.example to .gitconfig.local with your own credentials.
# * ...
```
