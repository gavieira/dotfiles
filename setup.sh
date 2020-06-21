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
USERNAME=$(whoami)

echo "creating symbolic links in /home/$username:"

# create symbolic link to this repo's .vimrc file
ln -s $scriptpath/.vimrc ~/.vimrc
echo ".vimrc symlink created"

# create symbolic link to repo's .vim dir
ln -s $SCRIPTPATH/.vim ~/.vim
echo ".vim directory symlink created"

# Create symbolic link to repo's .tmux_conf file
ln -s $SCRIPTPATH/.tmux.conf ~/.tmux.conf
echo ".tmux.conf symlink created"

# Create symbolic link to repo's .oh-my-zsh dir
ln -s $SCRIPTPATH/.oh-my-zsh ~/.oh-my-zsh
echo ".oh-my-zsh directory symlink created"

# Create symbolic link to repo's .zshrc file
ln -s $SCRIPTPATH/.zshrc ~/.zshrc
echo ".zshrc symlink created"

# Adding the command-line fuzzy finder - https://github.com/junegunn/fzf
echo "Installing the command-line fuzzy finder." 
yes | git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "Finished!!"
