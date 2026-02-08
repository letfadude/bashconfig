#!/bin/bash

echo updating...

config_path=$(pwd)
cd ~
user_home=$(pwd)

cd -

# starship
ln -sf $config_path/starship.toml $user_home/.config/starship.toml
if [ $? -ne 0 ]
then
  echo "ERR: startship config not linked"
else 
  echo "starship config linked"
fi

ln -sf $config_path/nvim $user_home/.config/nvim

if [ $? -ne 0 ]
then
  echo "ERR: nvim config not linked"
else 
  echo "nvim config linked"
fi

# Use new bashrc
ln -sf $config_path/.bashrc $user_home/.bashrc

if [ $? -ne 0 ]
then
  echo "ERR: bashrc config not linked"
else 
  echo "bashrc config linked"
fi

dconf load / < dconf.txt
if [ $? -ne 0 ]
then
  echo "ERR: dconf not loaded"
else 
  echo "dconf loaded"
fi

source ~/.bashrc

echo 'done'
