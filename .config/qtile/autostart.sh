#!/bin/sh

dropbox start &
nm-applet &
./.config/switch_monitors.sh &
setxkbmap -option caps:super && xmodmap -e "keycode 135 = Super_L" &


