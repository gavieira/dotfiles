#!/bin/sh

dropbox start &
nm-applet &
./.config/switch_monitors.sh &
#setxkbmap -option caps:super & #set CAPS to be an alternative super key
xmodmap -e "keycode 135 = Super_L" & #Rebinds the "Menu" key as an alternative super key


