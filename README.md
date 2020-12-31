# dotfiles

My WM-zsh-tmux-vim configuration.

## Prerequisites

You will need to install zsh, tmux and in your machine, as well as change the default shell to zsh

```
##On debian-based distros (e.g. Ubuntu):
sudo apt update && sudo apt install zsh tmux vim && chsh -s (which zsh)

##On arch-based distros (e.g. Manjaro):
sudo pacman -Syu zsh tmux vim && chsh -s (which zsh)
```

There are other dependencies (python3, fc-cache, xclip and xsel for instance), but they are probably already installed in your system.

## Installation

Run `sh /path/to/dotfiles/setup.py` to install the same terminal configuration in your machine. You can also check the [docker image](https://hub.docker.com/repository/docker/gavieira/myterminal). 

```
##Pulling image:
docker pull gavieira/myterminal:latest

##Creating and running container:
docker run --name termtest -it -e TERM gavieira/myterminal /bin/zsh

##Starting container:
docker start -i termtest
```

**Attention**: The setup script will remove previous zsh/tmux/vim configuration files in your home directory.

## Window Manager

I have dotfiles for both i3 and qtile (adpated from https://github.com/projetinho-bioinfo/dotfiles) WMs, as well as some applications (mpv, cmus, zathura, etc...)
