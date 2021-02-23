#!/bin/bash
# originally by Kris Occhipinti
# https://www.youtube.com/watch?v=FsQuGplQvrw

dunstify "Playing Video" "$(xclip -o)";
mpv "$(xclip -o)"
