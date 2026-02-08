#!/bin/bash

echo updating...

config_path=$(pwd)
user_home=$(eval echo ~) 

mkdir -p $user_home/.config

# starship
ln -sf $config_path/starship.toml $user_home/.config/starship.toml
if [ $? -ne 0 ]
then
  echo "ERR: startship config not linked"
else 
  echo "starship config linked"
fi

rm -rf "$user_home/.config/nvim"
if [ $? -ne 0 ]
then
  echo "ERR: nvim config could not be deleted"
else 
  echo "nvim config linked"
  ln -sf $config_path/nvim $user_home/.config/nvim
  if [ $? -ne 0 ]
  then
    echo "ERR: nvim config not linked"
  else 
    echo "nvim config linked"
  fi
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
