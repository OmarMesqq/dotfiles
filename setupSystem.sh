#!/bin/sh

# Firstly, update and upgrade system
sudo pacman -Syu 

sudo pacman -S openssh firewalld \
    fish \
    man-db \
    pacman-contrib \
    ranger

sudo systemctl enable firewalld.service
# Firewalld confs
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
