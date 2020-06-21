FROM alpine
MAINTAINER gavieira <gabrieldeusdeth@gmail.com>

## Copying repo to home folder

COPY / $HOME 

## Installing all required dependencies

RUN apk add git zsh tmux vim python3

## Set zsh as default shell

RUN sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd

##Adding python3 from base to mitofree env 
##(MITOS annotation tool requires python2, hence this additional step)

RUN ln -s /opt/conda/bin/python /opt/conda/envs/mitofree/bin/python3


##Finally, containers will open up at the /mnt directory, where volumes should be mounted

WORKDIR /mnt
