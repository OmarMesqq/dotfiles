#!/bin/sh

IS_LAPTOP=""


install_packages() {
    echo -e "\e[32mPackages to be installed:\e[0m"
    echo "$@"

    read -p "Do you want to install these packages? (y for yes, any other key for no): " choice

    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
        sudo pacman -S $@
    else
        echo "Installation cancelled."
    fi
}


install_basic_packages() {
    install_packages openssh firewalld fish man-db pacman-contrib ranger

    sudo systemctl enable firewalld.service
    sudo systemctl start firewalld.service

    wireless_interface=$(ip link | awk '/^[0-9]+: wl|^[0-9]+: wlan/ {print $2}' | sed 's/://')

    if [ -n "$wireless_interface" ]; then
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
}


ask_laptop_status() {
    read -p "Are you on a laptop? (y/Y for laptop, any other key for desktop): " user_choice

    user_choice=$(echo "$user_choice" | tr '[:upper:]' '[:lower:]')

    if [ "$user_choice" = "y" ]; then
        IS_LAPTOP="true"
    else
        IS_LAPTOP="false"
    fi
}


install_aur_package() {
    echo "Install $1? (y/Y or any other key for no)"
    read -p "Enter your choice: " package_choice
    package_choice=$(echo "$package_choice" | tr '[:upper:]' '[:lower:]')

    if [ "$package_choice" = "y" ]; then
        git clone "https://aur.archlinux.org/$2.git"
        cd "$2"
        makepkg -sric 
        cd ..
    fi 
}


install_kloak() {
    echo "Do you want to install Kloak? (y/Y for yes, any other key for no)"
    read -p "Enter your choice: " kloak_choice
    kloak_choice=$(echo "$kloak_choice" | tr '[:upper:]' '[:lower:]')

    if [ "$kloak_choice" = "y" ]; then
        echo "Installing Kloak"
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
            echo "Kloak installed and enabled."
        else
            echo "Kloak build failed. Not installed."
        fi

        cd ~
        rm -rf ~/kloak_build
    else
        echo "Kloak installation skipped."
    fi
}

install_emscripten() {
    echo "Install Emscripten? (y/Y for yes, any other key for no)"
    read -p "Enter your choice: " emscripten_choice
    emscripten_choice=$(echo "$emscripten_choice" | tr '[:upper:]' '[:lower:]')

    if [ "$emscripten_choice" = "y" ]; then 
        # Emscripten installation
        mkdir -p /home/$(whoami)/.emsdk
        git clone https://github.com/emscripten-core/emsdk.git .emsdk
        cd .emsdk
        ./emsdk install latest
        ./emsdk activate latest
        source ./emsdk_env.sh
    else
        echo "Skipping Emscripten installation."
    fi
}



# Start setup
sudo pacman -Syu 
ask_laptop_status
install_basic_packages


install_packages alacritty \
    qt5-wayland \
    qt6-wayland \
    polkit \
    waybar \
    sway \
    ueberzug \
    wmenu \
    wl-clipboard \
    swaybg \
    gammastep \
    grim \
    slurp \
    xorg-xwayland

install_packages noto-fonts-emoji \
    adobe-source-han-sans-otc-fonts \
    ttf-ubuntu-mono-nerd \
    ttf-font-awesome \
    otf-latinmodern-math \
    ttf-dejavu \
    otf-font-awesome


install_packages pavucontrol \
    pipewire-alsa \
    pipewire \
    pipewire-pulse \
    pipewire-jack 


install_packages bind \
    inetutils \
    whois \
    unzip \
    p7zip \
    docker \
    docker-buildx \
    qemu-desktop \
    android-tools \
    bmon \
    htop

sudo systemctl enable docker.service
sudo gpasswd -a $(whoami) docker 

install_packages zathura \
    zathura-pdf-mupdf \
    firefox \

install_packages obsidian syncthing texlive
install_packages code
install_packages go go-tools gopls delve
install_packages ghc ghc-static
install_packages rust rust-src
install_packages cmake gdb
install_packages tcl tk

# Home folder configuration
set -e
mkdir -p ~/.config/fish 
mkdir ~/.config/ranger
cp bashrc ~/.bashrc
cp config.fish ~/.config/fish
cp ranger/* ~/.config/ranger
cp mimeapps.list ~/.config

mkdir ~/scripts 
cp scripts/* ~/scripts 

mkdir ~/.config/alacritty 
mkdir ~/.config/sway
mkdir ~/.config/neofetch 
mkdir ~/.config/waybar
mkdir ~/.config/zathura 
mkdir -p ~/.config/nvim/lua

cp gitconfig ~/.gitconfig
cp apps/alacritty.toml ~/.config/alacritty 
cp apps/wgetrc ~/.wgetrc
cp apps/zathurarc ~/.config/zathura 
cp nvim/init.lua ~/.config/nvim
cp nvim/lua/plugins.lua ~/.config/nvim/lua

if [ "$IS_LAPTOP" = "true" ]; then
    install_packages i3lock \
    sof-firmware \
    acpi \
    bluez \
    bluez-utils \
    rtkit \

    cp apps/laptop/config ~/.config/sway
    cp apps/laptop/config.conf ~/.config/neofetch
    cp apps/laptop/config.jsonc ~/.config/waybar
else
    cp apps/desktop/config ~/.config/sway
    cp apps/desktop/config.conf ~/.config/neofetch
    cp apps/desktop/config.jsonc ~/.config/waybar
fi

# AUR packages 
mkdir ~/AUR
cd ~/AUR

install_aur_package "Code Features" "code-features"
install_aur_package "Code Marketplace" "code-marketplace"
install_aur_package "Stremio" "stremio-beta"
install_aur_package "Slack" "slack-desktop"

install_kloak
install_emscripten
