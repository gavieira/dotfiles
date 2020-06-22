#!/bin/sh

#This is the installer for my vimrc and tmux configurations

#Author: Gabriel Alves Vieira
#email: gabrieldeusdeth@gmail.com
#github: https://github.com/gavieira
#Date: 17 Jun 2020

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

echo "creating symbolic links in $HOME:"

# create symbolic link to this repo's .vimrc file
ln -s $SCRIPTPATH/.vimrc ~/.vimrc
echo ".vimrc symlink created"

# copy this repo's .vim dir
cp -r $SCRIPTPATH/.vim $HOME/.vim
echo ".vim directory copied"

# Installing vim plugins:
vim +'PlugInstall --sync' +qa
echo "vim plugins installed"

# Create symbolic link to repo's .tmux_conf file
ln -s $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf
echo ".tmux.conf symlink created"

# Install .oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --skip-chsh --unattended --keep-zshrc



# Installing plugins/themes for zsh shell:
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#zsh syntax highlighting:
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting



# Create symbolic link to repo's .zshrc file
ZSHRC=$HOME/.zshrc
rm $ZSHRC #Removes previous .zshrc file
ln -s $SCRIPTPATH/.zshrc $ZSHRC
echo ".zshrc symlink created"

echo "Finished!!"
