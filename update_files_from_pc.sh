#!/bin/bash
set -xuo pipefail

cp ~/.bashrc bashrc
cp ~/.gitconfig gitconfig
cp ~/.config/mimeapps.list .
cp ~/.wgetrc wgetrc

cp ~/.config/alacritty/alacritty.toml config/alacritty
cp ~/.config/fish/config.fish config/fish
cp ~/.config/gdb/* config/gdb

cp ~/.config/nvim/lua/plugins.lua config/nvim/lua
cp ~/.config/nvim/init.lua config/nvim

cp ~/.config/ranger/* config/ranger
cp ~/.config/sway/config config/sway
cp ~/.config/waybar/* config/waybar
cp ~/.config/zathura/zathurarc config/zathura

cp ~/scripts/* scripts/
