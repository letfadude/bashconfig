#!/bin/bash

echo updating...

config_path=$(pwd)
cd ~
user_home=$(pwd)

cd -

# starship
ln -sf $config_path/starship.toml $user_home/.config/starship.toml

ln -sf $config_path/nvim $user_home/.config/nvim

# Use new bashrc
ln -sf $config_path/.bashrc $user_home/.bashrc

dconf load / < dconf.txt

source ~/.bashrc

echo done
