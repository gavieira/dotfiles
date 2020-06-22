FROM alpine
MAINTAINER gavieira <gabrieldeusdeth@gmail.com>

## Setting HOME variable

ENV HOME /root

## Copying repo to home folder

COPY / $HOME 

## Installing all required dependencies

RUN apk add git zsh tmux vim python3

## Set zsh as default shell

RUN sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd

## Run installation script

RUN sh $HOME/dotfiles/setup.sh 


## Finally, set containers to open up at the $HOME directory

WORKDIR $HOME 
