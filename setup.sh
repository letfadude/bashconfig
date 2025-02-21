#!/bin/bash

# Install fonts
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O ~/Downloads/JetBrainsMono.zip
unzip ~/Downloads/JetBrainsMono.zip -d ~/.local/share/fonts

# Install starship
curl -sS https://starship.rs/install.sh | sh
cat ./starship.toml > ~/.config/starship.toml

# Install bat
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share
rm -rf ble-nightly

# Install bat
sudo apt install bat

# Install tmux
sudo apt install tmux
cat ./.tmux.conf > ~/.tmux.conf

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

cp -r ./nvim/ ~/.config/nvim 

# Use new bashrc
cat ./.bashrc > ~/.bashrc
