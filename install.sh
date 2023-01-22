#/bin/bash

# Determine the OS version
OS=$(lsb_release -si)
VERSION=$(lsb_release -sr)

# Install dependencies for each OS
if [ "$OS" == "CentOS" ] || [ "$OS" == "RedHat" ]; then
  if [ "$VERSION" == "7" ]; then
    yum install -y  zsh git curl
  elif [ "$VERSION" == "8" ]; then
    dnf install -y zsh git curl
  fi
elif [ "$OS" == "Debian" ]; then
  if [ "$VERSION" == "8" ]; then
    apt-get install -y zsh git curl
  elif [ "$VERSION" == "9" ]; then
    apt-get install -y zsh git curl
  fi
elif [ "$OS" == "Arch" ]; then
  pacman -S zsh git curl
elif [ "$OS" == "Raspbian" ]; then
  apt-get install -y zsh git curl
elif [ "$OS" == "Fedora" ]; then
  dnf install -y zsh git curl
elif [ "$OS" == "Ubuntu" ]; then
  apt-get install -y zsh git curl
elif [ "$OS" == "Kali" ]; then
  apt-get install -y zsh git curl
elif [ "$OS" == "Manjaro" ]; then
  pacman -S zsh git curl
else
  echo "This script does not support your OS."
  exit 1
fi

#Install startship prompt
curl -sS https://starship.rs/install.sh | sh
#Copy dotfiles to correct directory
mkdir ~/.config
cp ./zshrc /home/$USER/.zshrc
cp ./starship.toml /home/$USER/.config/
cd ~/.config
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd ~/
echo 'Installation complete, Please use "chsh" command and type "/bin/zsh" then restart terminal'
