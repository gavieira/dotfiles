#!/bin/bash
# originally by Kris Occhipinti
# https://www.youtube.com/watch?v=FsQuGplQvrw

notify-send -t 3000 "Playing Video" "$(xclip -o)";

if [[ $(xclip -o) == https://www.twitch.tv* ]] 
then
  streamlink --twitch-disable-ads "$(xclip -o)" 720p60 || mpv "$(xclip -o)"
else
  mpv "$(xclip -o)"
fi
