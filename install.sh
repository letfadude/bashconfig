#!/bin/bash

sudo apt update
sudo apt upgrade

# Install git
sudo apt install git

# Install fonts
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O ~/Downloads/JetBrainsMono.zip
unzip ~/Downloads/JetBrainsMono.zip -d ~/.local/share/fonts

# Install starship
curl -sS https://starship.rs/install.sh | sh
# cat ./starship.toml > ~/.config/starship.toml
# ln -s $(pwd)/starship.toml ~/.config/starship.toml

# Install bat
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share
rm -rf ble-nightly

# Install bat
sudo apt install bat -y

# Install tmux
sudo apt install tmux -y
# cat ./.tmux.conf > ~/.tmux.conf
# ln -s $(pwd)/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# color
mkdir -p ~/.config/tmux/plugins/catppuccin

# install go 
wget https://go.dev/dl/go1.25.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz
rm gol.25.5.linux-amd64.tar.gz

# golang support for vim
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# C support for vim
sudo apt install clangd -y

# arduino support for vim
cd ~
mkdir -p ~/arduino-cli
cd ~/arduino-cli
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh 
sudo mv ./bin/arduino-cli /usr/local/bin/arduino-cli

## install ripgrep for telescope
sudo apt install ripgrep -y
## install latexmk for vimtex
sudo apt install latexmk -y
## install zathura for pdf viewing
sudo apt install zathura -y
## TEX stuff
sudo apt-get install texlive-latex-recommended texlive-latex-extra -y
sudo apt-get install texlive-koma-script -y
sudo apt install biber -y
sudo apt install texlive-bibtex-extra -y
sudo apt install texlive-lang-english -y

## texlab lsp setup : download from : https://github.com/latex-lsp/texlab/releases
# tar -xvzf texlab-x86_64-linux.tar.gz
# sudo mv texlab /usr/local/bin/texlab






