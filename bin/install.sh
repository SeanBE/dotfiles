#! /bin/sh

# set up fedora machine
sudo dnf -y update

sudo dnf -y install zsh exa vim vim-enhanced vim-x11 alacritty

sudo dnf -y install sway swayidle swaylock waybar rofi \
  pavucontrol mako grim slurp wf-recorder wl-clipboard screenfetch acpi
 
sudo dnf -y install make lapack-devel git-delta blas-devel \
  ShellCheck gcc-c++ vim vim-enhanced pkgconf gcc docker \
  jq openssl-devel ansible

sudo dnf -y install weechat vlc ripgrep nmap htop ffmpeg \
  anki rclone ledger zathura duplicity ftp acpi fuse exfat-utils
