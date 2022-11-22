#!/bin/zsh

updates=$(checkupdates)
if [[ $(echo $updates | wc -l) -eq 0 ]]; then
    dunstify "NO UPDATES"
else
    dunstify "UPDATES" "$updates" -t 5000
fi
