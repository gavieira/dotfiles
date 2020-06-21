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
ln -s $scriptpath/.vimrc $HOME/.vimrc
echo ".vimrc symlink created"

# copy this repo's .vim dir
cp $SCRIPTPATH/.vim $HOME/.vim
echo ".vim directory copied"

# Installing vim plugins:
vim +'PlugInstall --sync' +qa
echo "vim plugins installed"

# Create symbolic link to repo's .tmux_conf file
ln -s $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf
echo ".tmux.conf symlink created"

# Install .oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Create symbolic link to repo's .oh-my-zsh dir
#ln -s $SCRIPTPATH/.oh-my-zsh $HOME/.oh-my-zsh
#echo ".oh-my-zsh directory symlink created"

# Create symbolic link to repo's .zshrc file
ln -s $SCRIPTPATH/.zshrc $HOME/.zshrc
echo ".zshrc symlink created"

# Adding the command-line fuzzy finder - https://github.com/junegunn/fzf
echo "Installing the command-line fuzzy finder." 
yes | git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install

echo "Finished!!"
