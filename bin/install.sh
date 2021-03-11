#! /bin/sh
set -e

# TODO: run sudo with script using zsh

# system depdencies
sudo dnf -y update
sudo dnf -y copr enable pschyska/alacritty
sudo dnf -y install \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
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
    restic \
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
    rclone bat \
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
    libpq-devel \
    pandoc texlive-scheme-full \
	youtube-dl mpv sxiv xv-devel

# python3-docutils

# Set zsh as the default shell
chsh -s /bin/zsh

# Install some languages
## Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install git-absorb
cargo install xsv
cargo install fd-find
cargo install alacritty
cargo install --locked --git https://github.com/dandavison/delta

## Golang
wget -O /tmp/go.tar.gz https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

go get github.com/yory8/clipman
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)"/bin v1.27.0

## build i3Blocks
git clone https://github.com/vivien/i3blocks
cd i3blocks
./autogen.sh
./configure
make
sudo make install

git clone https://github.com/vivien/i3blocks-contrib.git ~/.config/i3blocks/blocklets
cd ~/.config/i3blocks/blocklets/cpu_usage2 && make

# Misc
sudo usermod -aG docker "$USER" # satisfy docker post linux reqs.
sudo systemctl enable docker
mkdir -m 700 "$HOME/.ssh"
