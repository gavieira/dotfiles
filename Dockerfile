FROM alpine
MAINTAINER gavieira <gabrieldeusdeth@gmail.com>

## Setting HOME variable

ENV HOME /root

## Copying repo to home folder

COPY / $HOME/dotfiles 

## Installing all required dependencies and run installation script

RUN apk update && \
apk add git zsh bash tmux vim python3 fontconfig wget curl py3-setuptools && \
ln -s $(which python3) /usr/bin/python

## Set zsh as default shell - Some programs, like autojump, need to be installed under zsh or bash

ENV SHELL /bin/zsh

## Run installation script

RUN sh $HOME/dotfiles/setup.sh 

## Finally, set containers to open up at the $HOME directory

WORKDIR $HOME 
