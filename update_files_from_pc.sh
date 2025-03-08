#!/bin/sh
set -ex

cp ~/.config/alacritty/alacritty.toml config/alacritty 
cp ~/.config/sway/config config/sway
cp ~/.config/ranger/* config/ranger
cp ~/.config/waybar/* config/waybar
cp ~/.config/fish/config.fish config/fish
cp ~/.config/neofetch/config.conf config/neofetch
cp ~/.config/nvim/init.lua config/nvim
cp ~/.config/nvim/lua/plugins.lua config/nvim/lua
cp ~/.config/zathura/zathurarc config/zathura
cp ~/scripts/* scripts/
