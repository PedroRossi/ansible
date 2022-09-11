#!/bin/sh

SU="sudo"
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  xcode-select --install
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew install ansible
elif [ "$OS" = "Linux" ]; then
  DISTRO=$(head -n 1 /etc/issue | cut -d ' ' -f1)
  if [ "$DISTRO" = "Debian" ]; then
    SU=""
  fi
  # working with debian based linux only for now
  $SU apt update -y
  $SU apt upgrade -y
  $SU apt dist-upgrade -y
  $SU apt autoremove -y
  $SU apt autoclean -y
  $SU apt install -y software-properties-common make curl git
  $SU add-apt-repository --yes --update ppa:ansible/ansible
  $SU apt install -y ansible
else
  echo "OS Not supported"
  exit 1
fi
