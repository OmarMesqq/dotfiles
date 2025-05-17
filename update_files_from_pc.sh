#!/bin/sh
set -ex

cp ~/.config/alacritty/alacritty.toml config/alacritty 
cp ~/.config/i3/config config/i3
cp ~/.config/ranger/* config/ranger
cp ~/.config/polybar/* config/polybar
cp ~/.config/fish/config.fish config/fish
cp ~/.config/neofetch/config.conf config/neofetch
cp ~/.config/nvim/init.lua config/nvim
cp ~/.config/nvim/lua/plugins.lua config/nvim/lua
cp ~/.config/zathura/zathurarc config/zathura
cp ~/.config/gdb/* config/gdb
cp ~/.config/mimeapps.list .
cp ~/scripts/* scripts/
