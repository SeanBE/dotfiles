#! /bin/bash
sudo dnf update -y && sudo dnf install git ansible
git clone git@github.com:SeanBE/dotfiles.git ~/dotfiles

for f in *; do
    if [[ -d "$f" && "$f" != "ansible" ]]; then
		stow "$f"
    fi
done

ansible-playbook --ask-become-pass ansible/local.yml
