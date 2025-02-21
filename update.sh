#!/bin/bash

echo updating...

# starship
cat ./starship.toml > ~/.config/starship.toml

# tmux
cat ./.tmux.conf > ~/.tmux.conf

rm -rf ~/.config/nvim
cp -r ./nvim/ ~/.config/nvim 

# Use new bashrc
cat ./.bashrc > ~/.bashrc

source ~/.bashrc

echo done
