#!/bin/bash
# originally by Kris Occhipinti
# https://www.youtube.com/watch?v=FsQuGplQvrw

#This xclip command works both with Brave and qutebrowser
link=$(xclip -o -selection clipboard)

notify-send -t 3000 "Playing Video" "$link";

if [[ $link == https://www.twitch.tv* || $link == https://www.crunchyroll.com/* ]] 
then
  streamlink "$link" || mpv "$link"
else
  mpv "$link"
fi

#This should work as well (no need for the if)
#First tries to open with streamlink. If it fails, uses mpv as fallback option.
#streamlink "$link" || mpv "$link"
