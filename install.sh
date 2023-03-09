#!/bin/bash

echo "Please note that this script performs a backup of the current .zshrc file before replacing it with the custom configuration files. Also, please verify that the configuration file paths are correct before running the script to avoid deleting important files."

read -p "Are you sure you want to continue? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Determine the OS version
if command -v lsb_release > /dev/null; then
  OS=$(lsb_release -si)
  VERSION=$(lsb_release -sr)
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  OS=$ID
  VERSION=$VERSION_ID
elif [ -f /etc/arch-release ]; then
  OS="Arch"
  VERSION=$(pacman -Q archlinux | awk '{print $2}')
elif [ -f /etc/fedora-release ]; then
  OS="Fedora"
  VERSION=$(rpm -q --queryformat '%{VERSION}' fedora-release)
elif [ -f /etc/redhat-release ]; then
  OS=$(cat /etc/redhat-release | awk '{print $1}')
  VERSION=$(cat /etc/redhat-release | awk '{print $3}')
elif [ -f /etc/raspbian-release ]; then
  OS="Raspbian"
  VERSION=$(cat /etc/raspbian-release | awk '{print $2}')
elif [ -f /etc/kali-version ]; then
  OS="Kali"
  VERSION=$(cat /etc/kali-version | awk '{print $1}')
elif [ -f /etc/manjaro-release ]; then
  OS="Manjaro"
  VERSION=$(cat /etc/manjaro-release | awk '{print $2}')
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VERSION=$DISTRIB_RELEASE
else
  echo "This script does not support your OS."
  exit 1
fi

# Install dependencies for each OS
case "$OS" in
    "CentOS"|"RedHat")
        if [[ "$VERSION" == "7" ]]; then
            sudo yum install -y zsh git curl
        elif [[ "$VERSION" == "8" ]]; then
            sudo dnf install -y zsh git curl
        fi
        ;;
    "Debian")
        if [[ "$VERSION" == "8" || "$VERSION" == "9" ]]; then
            sudo apt-get install -y zsh git curl
        fi
        ;;
    "Arch")
        sudo pacman -S zsh git curl
        ;;
    "Raspbian"|"Fedora"|"Ubuntu"|"Kali"|"Manjaro")
        sudo apt-get install -y zsh git curl
        ;;
    *)
        echo "This script does not support your OS."
        exit 1
esac

# Install the Starship prompt
curl -fsSL https://starship.rs/install.sh | sh

# Backup current .zshrc file
cp ~/.zshrc ~/.zshrc.bak

# Copy custom config files
cp ./zshrc ~/.zshrc
mkdir -p ~/.config/
cp -r ./starship.toml ~/.config/

# Clone additional repositories for autocomplete and syntax highlighting
mkdir -p ~/.config/ && cd ~/.config/
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
cd ~/
echo 'Installation complete. Please restart your terminal to start using the new prompt.'
