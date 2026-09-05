#!/bin/bash

logfile="install.log"
packages=(git curl wget tilix bat tmux xsel wl-clipboard xclip clangd ripgrep latexmk zathura texlive-full texlab flatpak openvpn podman erlang rebar3 elixir build-essential mosquitto mosquitto-clients wireguard wireguard-tools)

echo "Starting install script .." > "$logfile"
echo "apt packages: "

for pkg in "${packages[@]}";
do 
  echo -n " $pkg" 
done
echo 
echo "install apt packages $packages ? {y/n}"
read inst
i=0
if [ "$inst" == 'y' ]
then
  echo "*** UPDATING PACKAGE MANAGER ***" | tee -a "$logfile"
  sudo apt update 2>&1 >> "$logfile" 
  sudo apt upgrade -y 2>&1 >> "$logfile"
  echo "*** INSTALLING APT PACKAGES ***" | tee -a "$logfile"

  for pkg in "${packages[@]}"; 
  do 
    ((i++))
    echo "** installing $pkg **" | tee -a "$logfile"
    sudo apt install $pkg -y 2>&1 >> "$logfile"
    if [ $? -ne 0 ]
    then
      echo "*** INSTALL FAILED [$pkg]***" | tee -a "$logfile"
    else 
      echo "** $pkg installed successfully **" | tee -a "$logfile"
      echo "-" | tee -a "$logfile"
    fi
  done
fi

./install_brave.sh 2>&1 >> "$logfile"

echo "*** INSTALLING $i APT PACKAGES DONE ***" | tee -a "$logfile"
echo "add default flatpak repository ? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>&1 >> "$logfile"
fi

echo "proceed to addon installations ? [y/n]"
read proceed
if [ "$proceed" != 'y' ]
then 
  echo "Addon installations skipped" | tee -a "$logfile"
  exit 0
fi
%lets see
  
echo "*** ADDONS INSTALLATION ***" | tee -a "$logfile"

addon="tilix colors"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  git clone https://codeberg.org/SnowCode/tilix-colors.git 2>&1 >> "$logfile"
  mkdir -p ~/.config/tilix/schemes 2>&1 >> "$logfile"
  mv tilix-colors/*.json ~/.config/tilix/schemes 2>&1 >> "$logfile"
  rm -r tilix-colors 2>&1 >> "$logfile"
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="jetbrains-font"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  # Install fonts
  mkdir -p ~/.local/share/fonts
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip -O ~/Downloads/JetBrainsMono.zip 2>&1 >> "$logfile"
  unzip ~/Downloads/JetBrainsMono.zip -d ~/.local/share/fonts 2>&1 >> "$logfile"
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="starship"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  curl -sS https://starship.rs/install.sh | sh 2>&1 >> "$logfile"
  if [ $? -ne 0 ]
  then 
    echo "installing addon [$addon] failed"
  fi
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="ble-nighlty"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - 2>&1 >> "$logfile"
  bash ble-nightly/ble.sh --install ~/.local/share 2>&1 >> "$logfile"
  rm -rf ble-nightly 2>&1 >> "$logfile"
else 
  echo "$addon installation skipped" | tee -a "$logfile"
fi


# Install tmux with catppuccin
addon="tmux catppuccin theme"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** SETTING TMUX COLOR SCHEME TO CATPPUCCIN ***" | tee -a "$logfile"
  mkdir -p ~/.config/tmux/plugins/catppuccin 2>&1 >> "$logfile"
  git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux 2>&1 >> "$logfile"
  # color
  mkdir -p ~/.config/tmux/plugins/catppuccin 2>&1 >> "$logfile"
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

# Install neovim
addon="nvim"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz 2>&1 >> "$logfile"
  sudo rm -rf /opt/nvim-linux-x86_64 2>&1 >> "$logfile"
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz 2>&1 >> "$logfile"
  sudo rm nvim-linux-x86_64.tar.gz 2>&1 >> "$logfile"
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

# install go 
addon="golang and golang-langserver"

echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  echo "*** INSTALLING [$addon] ***" | tee -a "$logfile"
  wget https://go.dev/dl/go1.25.5.linux-amd64.tar.gz 2>&1 >> "$logfile"
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz 2>&1 >> "$logfile"
  rm go1.25.5.linux-amd64.tar.gz 2>&1 >> "$logfile"

  # golang support for vim
  echo "*** INSTALLING GOLANG SUPPORT FOR NVIM ***" | tee -a "$logfile"
  go install golang.org/x/tools/gopls@latest 2>&1 >> "$logfile"
  go install github.com/nametake/golangci-lint-langserver@latest 2>&1 >> "$logfile"
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest 2>&1 >> "$logfile"
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

addon="arduino-cli"
echo "install $addon? [y/n]"
read inst
if [ "$inst" == 'y' ]
then
  # arduino support for vim
  echo "*** INSTALLING [$addon] ***"| tee -a "$logfile"
  cd ~
  mkdir -p ~/arduino-cli
  cd ~/arduino-cli
  curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh 2>&1 >> "$logfile"
  sudo mv ./bin/arduino-cli /usr/local/bin/arduino-cli 2>&1 >> "$logfile"
else
  echo "$addon installation skipped" | tee -a "$logfile"
fi

echo "*** INSTALLATION COMPLETE ***"

echo "update configs ? [y/n]"
read update

if [ "$update" != 'y' ]
then
  echo "update skipped -> use update.sh"
  exit 0
fi

echo "*** UPDATING CONFIG ***"
/bin/bash ./update.sh
if [ $? -ne 0 ]
then
  echo "update failed try again <update.sh>"
fi
