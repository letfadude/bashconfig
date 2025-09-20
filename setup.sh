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

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

cp -r ./nvim/ ~/.config/nvim 

mkdir -p ~/.config/tmux/plugins/catppuccin

# golang support for vim
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# C support for vim
sudo apt install clangd

# arduino support for vim
cd ~
mkdir -p ~/arduino-cli
cd ~/arduino-cli
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh 
sudo mv ./bin/arduino-cli /usr/local/bin/arduino-cli

## install ripgrep for telescope
sudo apt install ripgrep
## install latexmk for vimtex
sudo apt install latexmk
## install zathura for pdf viewing
sudo apt install zathura
## TEX stuff
sudo apt-get update
sudo apt-get install texlive-latex-recommended texlive-latex-extra
sudo apt-get install texlive-koma-script
sudo apt install biber
sudo apt install texlive-bibtex-extra
sudo apt install texlive-lang-english
## texlab lsp setup : download from : https://github.com/latex-lsp/texlab/releases
tar -xvzf texlab-x86_64-linux.tar.gz
sudo mv texlab /usr/local/bin/texlab






