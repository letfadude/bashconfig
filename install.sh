#!/bin/bash

logfile="install.log"

echo "Starting install script .." > "$logfile"

packages=(git curl wget tilix bat tmux xsel wl-clipboard xclip clangd ripgrep latexmk zathura texlive-full)
echo "install apt packages $packages ? {y/n}"
read inst
i=0
if [ $inst == 'y' ]
then
  echo "*** UPDATING PACKAGE MANAGER ***" | tee -a "$logfile"
  sudo apt update >> "$logfile" 
  sudo apt upgrade >> "$logfile"
  echo "*** INSTALLING APT PACKAGES ***" | tee -a "$logfile"

  for pkg in "${packages[@]}"; 
  do 
    ((i++))
    echo "** installing $pkg **" | tee -a "$logfile"
    sudo apt install $pkg -y >> "$logfile"
    if [ $? -ne 0 ]
    then
      echo "*** INSTALL FAILED [$pkg]***" | tee -a "$logfile"
    else 
      echo "** $pkg installed successfully **" | tee -a "$logfile"
      echo "-" | tee -a "$logfile"
    fi
  done
fi

echo "*** INSTALLING $i APT PACKAGES DONE ***" | tee -a "$logfile"
echo "proceed to addon installations ? [y/n]"
read proceed
if [ $proceed != 'y' ]
then 
  echo "Addon installations skipped" | tee -a "$logfile"
  exit 0
fi
  
echo "*** ADDONS INSTALLATION ***" | tee -a "$logfile"
addon="tilix"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING TILIX COLOR SCHEMES ***" | tee -a "$logfile"
  git clone https://codeberg.org/SnowCode/tilix-colors.git
  mkdir -p ~/.config/tilix/schemes
  mv tilix-colors/*.json ~/.config/tilix/schemes
  rm -r tilix-colors
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="jetbrains-font"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING JETBRAINS FONT ***" | tee -a "$logfile"
  # Install fonts
  mkdir -p ~/.local/share/fonts
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O ~/Downloads/JetBrainsMono.zip
  unzip ~/Downloads/JetBrainsMono.zip -d ~/.local/share/fonts
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="starship"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING STARSHIP ***" | tee -a "$logfile"
  curl -sS https://starship.rs/install.sh | sh
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="ble-nighlty"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING BLE-NIGHTLY ***" | tee -a "$logfile"
  curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
  bash ble-nightly/ble.sh --install ~/.local/share
  rm -rf ble-nightly
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

# Install tmux with catppuccin

addon="tmux catppuccin theme"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** SETTING TMUX COLOR SCHEME TO CATPPUCCIN ***" | tee -a "$logfile"
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
  # color
  mkdir -p ~/.config/tmux/plugins/catppuccin
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

# Install neovim
addon="nvim"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING NVIM ***" | tee -a "$logfile"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim-linux-x86_64
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  sudo rm nvim-linux-x86_64.tar.gz
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

# install go 
addon="golang and golang-langserver"

echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  echo "*** INSTALLING GOLANG ***" | tee -a "$logfile"
  wget https://go.dev/dl/go1.25.5.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz
  rm go1.25.5.linux-amd64.tar.gz

  # golang support for vim
  echo "*** INSTALLING GOLANG SUPPORT FOR NVIM ***" | tee -a "$logfile"
  go install github.com/nametake/golangci-lint-langserver@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="arduino-cli"
echo "install $addon? [y/n]"
read inst
if [ $inst == 'y' ]
then
  # arduino support for vim
  echo "*** INSTALLING ARDUINO_CLI ***" | tee -a "$logfile"
  cd ~
  mkdir -p ~/arduino-cli
  cd ~/arduino-cli
  curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh 
  sudo mv ./bin/arduino-cli /usr/local/bin/arduino-cli
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

echo "*** INSTALLATION COMPLETE ***"

echo "update configs ? [y/n]"
read update

if [ update != 'y' ]
then
  echo "update skipped -> use update.sh"
  exit 0
fi

echo "*** UPDATING CONFIG ***"
/bin/bash update.sh
if [ $? -ne 0 ]
then
  echo "update failed try again <update.sh>"
fi




