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
   swaybg \
   swayidle \
   swaylock \
   ueberzug \
   wmenu \
   wl-clipboard \
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

sudo systemctl enable docker.socket
sudo gpasswd -a $(whoami) docker 

install_packages zathura \
   zathura-pdf-mupdf \

install_packages cmake gdb
install_packages tcl tk

# Home folder configuration
set -e
mkdir -p ~/.config/fish 
mkdir -p ~/.config/ranger
mkdir -p ~/scripts 
mkdir -p ~/.config/alacritty 
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.config/zathura 
mkdir -p ~/.config/nvim/lua

cp ../scripts/* ~/scripts 

cp ../bashrc ~/.bashrc
cp ../mimeapps.list ~/.config
cp ../gitconfig ~/.gitconfig
cp ../wgetrc ~/.wgetrc


cp ../config/fish/config.fish ~/.config/fish
cp ../config/ranger/* ~/.config/ranger


cp ../config/alacritty/alacritty.toml ~/.config/alacritty 
cp ../config/zathura/zathurarc ~/.config/zathura 
cp ../config/nvim/init.lua ~/.config/nvim
cp ../config/nvim/lua/plugins.lua ~/.config/nvim/lua
cp ../config/sway/config ~/.config/sway
cp ../config/waybar/* ~/.config/waybar

# AUR packages 
mkdir -p ~/AUR
cd ~/AUR

install_kloak
