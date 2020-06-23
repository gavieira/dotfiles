FROM alpine
MAINTAINER gavieira <gabrieldeusdeth@gmail.com>

## Setting HOME variable

ENV HOME /root

## Copying repo to home folder

COPY / $HOME/dotfiles 

## Installing all required dependencies and run installation script

RUN apk update && \
apk add git zsh bash tmux vim python3 fontconfig curl py3-setuptools && \
ln -s $(which python3) /usr/bin/python &&\
sh $HOME/dotfiles/setup.sh 

## Set zsh as default shell

ENV SHELL /bin/zsh

## Finally, set containers to open up at the $HOME directory

WORKDIR $HOME 
