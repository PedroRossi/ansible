#!/bin/sh


OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  xcode-select --install
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew install ansible
elif [ "$OS" = "Linux" ]; then
  # working with debian based linux only for now
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt dist-upgrade -y
  sudo apt autoremove -y
  sudo apt autoclean -y
  sudo apt install software-properties-common
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
else
  echo "OS Not supported"
  exit 1
fi
