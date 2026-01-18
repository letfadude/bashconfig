#!/bin/bash

echo updating...

config_path=$(pwd)
cd ~
user_home=$(pwd)

cd -

# starship
rm -rf $user_home/.config/starship.toml
ln -s $config_path/starship.toml $user_home/.config/starship.toml
#cat ./starship.toml > ~/.config/starship.toml

# tmux
#cat ./.tmux.conf > ~/.tmux.conf

rm -rf ~/.config/nvim
ln -s $config_path/nvim $user_home/.config/nvim

# Use new bashrc
rm -f $user_home/.bashrc 
ln -s $config_path/.bashrc $user_home/.bashrc
#cat ./.bashrc > ~/.bashrc

source ~/.bashrc

echo done
