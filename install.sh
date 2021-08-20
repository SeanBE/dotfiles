#! /bin/bash
sudo dnf update -y && sudo dnf install -y git ansible stow

git clone https://github.com/SeanBE/dotfiles.git ~/dotfiles
cd ~/dotfiles
git submodule update --init

for f in *; do
    if [[ -d "$f" && "$f" != "ansible" ]]; then
		stow "$f"
    fi
done

ansible-playbook --ask-become-pass --tags all ansible/local.yml
