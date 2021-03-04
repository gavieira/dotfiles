#!/bin/bash
# originally by Kris Occhipinti
# https://www.youtube.com/watch?v=FsQuGplQvrw

notify-send -t 3000 "Playing Video" "$(xclip -o)";

if [[ $(xclip -o) == https://www.twitch.tv* || $(xclip -o) == https://www.crunchyroll.com/* ]] 
then
  streamlink "$(xclip -o)" || mpv "$(xclip -o)"
else
  mpv "$(xclip -o)"
fi

#This should work as well (no need for the if)
#First tries to open with streamlink. If it fails, uses mpv as fallback option.
#streamlink "$(xclip -o)" || mpv "$(xclip -o)"
