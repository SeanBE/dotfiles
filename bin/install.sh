#! /bin/sh
set -e
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
    nfs-utils \
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
    blas-devel \
    libtool autoconf \
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
    postgresql \
    zlib-devel \
    zathura \
    zathura-pdf-mupdf \
    ftp \
    acpi \
    fuse \
    exfat-utils \
    powertop tlp \
    light \
    libffi-devel \
    bzip2 bzip2-devel \
    readline-devel \
    sqlite sqlite-devel \
    tk-devel \
    chromium \
    docker-compose \
    libpq-devel

# TODO: clean this part up.
# install some languages
wget -O /tmp/go.tar.gz https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install git-absorb
cargo install --locked --git https://github.com/dandavison/delta
go get github.com/yory8/clipman

git clone https://github.com/vivien/i3blocks
cd i3blocks
./autogen.sh
./configure
make
sudo make install

git clone https://github.com/vivien/i3blocks-contrib.git ~/.config/i3blocks/blocklets

cd ~/.config/i3blocks/blocklets/cpu_usage2 
make

curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.27.0

sudo usermod -aG docker "$USER" # satisfy docker post linux reqs.
sudo systemctl enable docker

# misc
mkdir -m 700 "$HOME/.ssh"
