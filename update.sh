#!/bin/bash

echo updating...

config_path=$(pwd)
user_home=$(eval echo ~) 

mkdir -p $user_home/.config

echo "setting git config"
git config --global pull.rebase false
git config --global user.name "fadude"
git config --global user.email "wallneralex7789@gmail.com"
git config --global alias.lol "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global core.editor "vi"

# starship
ln -sf $config_path/starship.toml $user_home/.config/starship.toml
if [ $? -ne 0 ]
then
  echo "ERR: startship config not linked"
else 
  echo "starship config linked"
fi

# nvim 
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

# bashrc
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
