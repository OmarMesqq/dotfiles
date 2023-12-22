#!/bin/sh
set -e

# Firstly, update and upgrade system
sudo pacman -Syu 

sudo pacman -S openssh firewalld \
    fish \
    man-db \
    pacman-contrib \
    ranger

sudo systemctl enable firewalld.service
wireless_interface=$(ip link | awk '/^[0-9]+: wl|^[0-9]+: wlan/ {print $2}' | sed 's/://')

if [ -n "$wireless_interface" ]; then 
    echo "Found a wireless Interface: $wireless_interface"
    sudo firewall-cmd --zone=public --change-interface=$wireless_interface
    # Disable SSH server allowance
    sudo firewall-cmd --zone=public --remove-service ssh
    sudo firewall-cmd --runtime-to-permanent
    sudo systemctl restart firewalld.service
else 
    echo "No wireless interface found. NOT CONFIGURING FIREWALL"
fi

sudo systemctl enable fstrim.timer
sudo systemctl enable paccache.timer

# GUI setup 
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
    gnome-themes-extra

# Fonts 
sudo pacman -S noto-fonts-emoji \
    adobe-source-han-sans-otc-fonts \
    ttf-ubuntu-mono-nerd \
    ttf-font-awesome \
    otf-latinmodern-math

# Some tools 
sudo pacman -S bind \
    inetutils \
    whois \
    unzip \
    p7zip \
    docker \
    docker-buildx \
    libguestfs \
    qemu-desktop

sudo systemctl enable docker.service

# Laptop?
sudo pacman -S i3lock \
    sof-firmware \
    acpi \
    bluez \
    bluez-utils \
    rtkit \
    xorg-xrandr \
    xorg-xbacklight

# Sound 
sudo pacman -S pavucontrol \
    pipewire-alsa \
    pipewire \
    pipewire-pulse \
    pipewire-jack 


sudo pacman -S zathura \
    zathura-pdf-mupdf \
    firefox

# Install programming languages/tools? 
sudo pacman -S code \
    cmake \
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
    typescript
