#!/bin/bash
# originally by Kris Occhipinti
# https://www.youtube.com/watch?v=FsQuGplQvrw

notify-send -t 5000 "Playing Video" "$(xclip -o)";
mpv "$(xclip -o)"
