#/bin/bash

clear
#Install dependency
echo 'Installation of dependencie please wait'
sudo apt-get install zsh neofetch lolcat figlet
#Install startship prompt
curl -sS https://starship.rs/install.sh | sh
#Copy dotfiles to correct directory
cp ./zshrc /home/$USER/.zshrc
cp ./starship.toml /home/$USER/.config/

echo 'Installation complete please restart terminal'
