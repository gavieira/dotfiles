#!/bin/bash

# Get current song (Title - Artist or Filename as fallback)
# We use --wait to ensure we get data before the script continues
RAW_TITLE=$(mpc -f "[[%artist% - ]%title%]|[%file%]" current)

if [ -z "$RAW_TITLE" ]; then
    echo "{\"text\": \"Stopped\", \"class\": \"stopped\"}"
    exit 0
fi

# Escape special characters for Waybar (Pango)
# This handles &, <, >, and quotes which often cause "N/A"
SAFE_TITLE=$(echo "$RAW_TITLE" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\\"/g')

STATE=$(mpc status %state%)
PERCENT=$(mpc status %percenttime%)
ICON=""
[[ "$STATE" == "paused" ]] && ICON=""

# JSON output
echo "{\"text\": \"$ICON $SAFE_TITLE ($PERCENT)\", \"tooltip\": \"$RAW_TITLE\", \"class\": \"$STATE\"}"
