#! /bin/sh
sudo dnf -y update

sudo dnf copr enable pschyska/alacritty
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm

sudo dnf -y install \
    zsh \
    exa \
    vim \
    vim-enhanced \
    vim-X11 \
    alacritty \
    nfs-kernel \
    nfs-common \
    sway \
    swayidle \
    swaylock \
    waybar \
    rofi \
    pavucontrol \
    mako \
    grim \
    slurp \
    wf-recorder \
    wl-clipboard \
    screenfetch \
    acpi \
    make \
    lapack-devel \
    git-delta \
    blas-devel \
    ShellCheck \
    gcc-c++ \
    pkgconf \
    gcc \
    docker \
    jq \
    openssl-devel \
    ansible \
    weechat \
    vlc \
    ripgrep \
    nmap \
    htop \
    ffmpeg \
    rclone \
    zathura \
    ftp \
    acpi \
    fuse \
    exfat-utils 

# install some languages
wget -O /tmp/go.tar.gz https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install git-absorb
cargo install --locked --git https://github.com/dandavison/delta
go get github.com/yory8/clipman

# misc
mkdir -m 700 "$HOME/.ssh"
