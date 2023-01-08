#/bin/bash

clear
#Install dependency
echo 'Installation of dependencie please wait'
sudo apt-get install zsh neofetch lolcat figlet curl
#Install startship prompt
curl -sS https://starship.rs/install.sh | sh
#Copy dotfiles to correct directory
mkdir ~/.config
cp ./zshrc /home/$USER/.zshrc
cp ./starship.toml /home/$USER/.config/
cd ~/.config
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd
echo 'Installation complete, Please use "chsh" command and type "/bin/zsh" please restart terminal'
