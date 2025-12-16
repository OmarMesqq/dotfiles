#!/bin/sh
set -x

cp ~/.config/alacritty/alacritty.toml config/alacritty 
cp ~/.config/sway/config config/sway
cp ~/.config/ranger/* config/ranger
cp ~/.config/waybar/* config/waybar
cp ~/.config/fish/config.fish config/fish
cp ~/.config/nvim/init.lua config/nvim
cp ~/.config/nvim/lua/plugins.lua config/nvim/lua
cp ~/.config/zathura/zathurarc config/zathura
cp ~/.config/gdb/* config/gdb
cp ~/.config/mimeapps.list .
cp ~/scripts/* scripts/
