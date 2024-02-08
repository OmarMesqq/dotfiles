#!/bin/sh

# Firstly, update and upgrade system
sudo pacman -Syu 

# Basic services and packages
sudo pacman -S openssh firewalld \
    fish \
    man-db \
    pacman-contrib \
    ranger

sudo systemctl enable firewalld.service
sudo systemctl start firewalld.service

wireless_interface=$(ip link | awk '/^[0-9]+: wl|^[0-9]+: wlan/ {print $2}' | sed 's/://')

if [ -n "$wireless_interface" ]; then 
    echo "Found a wireless Interface: $wireless_interface"
    sudo firewall-cmd --zone=public --change-interface=$wireless_interface
    ## Disable SSH server allowance
    sudo firewall-cmd --zone=public --remove-service ssh
    sudo firewall-cmd --runtime-to-permanent
    sudo systemctl restart firewalld.service
else 
    echo "No wireless interface found. NOT CONFIGURING FIREWALL"
fi

sudo systemctl enable fstrim.timer
sudo systemctl enable paccache.timer

## GUI setup 
sudo pacman -S xorg-server \
    xorg-xinit \
    xorg-xhost \
    alacritty \
    picom \
    polybar \
    i3-wm \
    w3m \
    dmenu \
    feh \
    redshift \
    lxappearance \
    gnome-themes-extra \
    numlockx \
    scrot

## Fonts 
sudo pacman -S noto-fonts-emoji \
    adobe-source-han-sans-otc-fonts \
    ttf-ubuntu-mono-nerd \
    ttf-font-awesome \
    otf-latinmodern-math \
    ttf-dejavu

## Sound 
sudo pacman -S pavucontrol \
    pipewire-alsa \
    pipewire \
    pipewire-pulse \
    pipewire-jack 


## Laptop?
sudo pacman -S i3lock \
    sof-firmware \
    acpi \
    bluez \
    bluez-utils \
    rtkit \
    xorg-xrandr \
    xorg-xbacklight

## Some more tools 
sudo pacman -S bind \
    inetutils \
    whois \
    unzip \
    p7zip \
    docker \
    docker-buildx \
    libguestfs \
    qemu-desktop \
    android-tools

sudo systemctl enable docker.service

sudo pacman -S zathura \
    zathura-pdf-mupdf \
    firefox \
    code \
    neovim \
    xclip

## Install programming languages/tools? 
sudo pacman -S cmake \
    delve   \
    ghc \
    ghc-static \
    go \
    go-tools \
    gopls \
    ocaml \
    npm \
    re2c \
    rust \
    rust-src \
    tcl \
    tk \
    typescript \
    gdb \
    clang \
    llvm \

set -e
# Configuration files
mkdir -p ~/.config/fish 
mkdir ~/.config/ranger
cp bashrc ~/.bashrc
cp config.fish ~/.config/fish
cp xorg/xinitrc ~/.xinitrc
cp xorg/xserverrc ~/.xserverrc
cp ranger/* ~/.config/ranger
cp mimeapps.list ~/.config

mkdir ~/scripts 
cp scripts/* ~/scripts 

mkdir ~/.config/alacritty 
mkdir ~/.config/i3
mkdir ~/.config/neofetch 
mkdir ~/.config/polybar
mkdir ~/.config/zathura 
mkdir ~/.config/picom

cp apps/alacritty.toml ~/.config/alacritty 
cp apps/vimrc ~/.vimrc
cp apps/wgetrc ~/.wgetrc
cp apps/zathurarc ~/.config/zathura 

echo "Are you on a laptop? (y/Y for laptop, any other key for desktop)"
read -p "Enter your choice: " user_choice

is_laptop=$(echo "$user_choice" | tr '[:upper:]' '[:lower:]')

if [ "$is_laptop" ="y" ]; then 
    sudo cp apps/laptop/40-libinput.conf /etc/X11/xorg.conf.d
    cp apps/laptop/config ~/.config/i3
    cp apps/laptop/config.conf ~/.config/neofetch
    cp apps/laptop/config.ini ~/.config/polybar
    cp apps/laptop/picom.conf ~/.config/picom
else 
    cp apps/desktop/config ~/.config/i3
    cp apps/desktop/config.conf ~/.config/neofetch
    cp apps/desktop/config.ini ~/.config/polybar
    cp apps/desktop/picom.conf ~/.config/picom
fi

# AUR packages 
mkdir ~/AUR
cd ~/AUR

git clone https://aur.archlinux.org/code-features.git
cd code-features
makepkg -sric 
cd ..

git clone https://aur.archlinux.org/code-marketplace.git
cd code-marketplace 
makepkg -sric 
cd .. 

echo "Install Stremio? (y/Y or any other key for no)"
read -p "Enter your choice: " stremio_choice
stremio_choice=$(echo "$stremio_choice" | tr '[:upper:]' '[:lower:]')

if [ "$stremio_choice" = "y" ]; then 
    git clone https://aur.archlinux.org/stremio-beta.git
    cd stremio-beta
    makepkg -sric 
    cd ..
fi 

echo "Install Slack? (y/Y or any other key for no)"
read -p "Enter your choice: " slack_choice
slack_choice=$(echo "$slack_choice" | tr '[:upper:]' '[:lower:]')

if [ "$slack_choice" = "y" ]; then 
    git clone https://aur.archlinux.org/slack-desktop.git
    cd slack-desktop
    makepkg -sric 
    cd ..
fi 

# Installing kloak
sudo pacman -S libsodium
mkdir -p ~/kloak_build
cd ~/kloak_build
git clone https://github.com/vmonaco/kloak .
make all

if [ -f kloak ] && [ -f eventcap ]; then
    sudo cp kloak /usr/sbin/kloak
    sudo cp eventcap /usr/sbin/eventcap
    sudo cp lib/systemd/system/kloak.service /etc/systemd/system
    sudo systemctl enable kloak.service
    sudo systemctl start kloak.service
else
    echo "Kloak build failed. Not installed."
fi

cd ~
rm -rf ~/kloak_build


# Symlinking standard download location to external HD
ln -s /home/$(whoami)/j/downloads ~/Downloads

