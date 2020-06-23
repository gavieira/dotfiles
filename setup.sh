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

# copy this repo's .vim dir
cp -r $SCRIPTPATH/.vim $HOME/.vim
echo ".vim directory copied"

# Install .oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --skip-chsh --unattended --keep-zshrc


# Installing plugins/themes for zsh shell:
echo "Installing plugins/themes for zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#zsh syntax highlighting:
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#autojump:
echo "Installing autojump"
AUTOJUMP_DIR=$HOME/.oh-my-zsh/custom/plugins/autojump
git clone https://github.com/wting/autojump.git $AUTOJUMP_DIR
cd $AUTOJUMP_DIR && ./install.py && cd -

# INSTALL FONTS AND POWERLEVEL10k
# Code from https://github.com/jotyGill/quickz-sh/blob/master/quickz.sh

echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/
wget -q -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
	    cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull
    else
	        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

echo "creating symbolic links in $HOME:"

# create symbolic link to this repo's .vimrc file
rm $HOME/.vimrc
ln -s $SCRIPTPATH/.vimrc ~/.vimrc
echo ".vimrc symlink created"

# Installing vim plugins:
vim +'PlugInstall --sync' +qa
#vim -E -s -u "path_to_vim_rc/.vimrc" +PlugInstall +qall # From https://github.com/junegunn/vim-plug/issues/225#issuecomment-458710986
echo "vim plugins installed"

# Create symbolic link to repo's .tmux_conf file
rm $HOME/.tmux.conf
ln -s $SCRIPTPATH/.tmux.conf $HOME/.tmux.conf
echo ".tmux.conf symlink created"

# Create symbolic link to .p10k.zsh
rm $HOME/.p10k.zsh
ln -s $SCRIPTPATH/.p10k.zsh $HOME/.p10k.zsh
echo ".p10k.zsh symlink created"

# Create symbolic link to repo's .zshrc file
rm $HOME/.zshrc #Removes previous .zshrc file
ln -s $SCRIPTPATH/.zshrc $HOME/.zshrc 
echo ".zshrc symlink created"


echo "Finished!!"
