#!/bin/zsh

updates=$(checkupdates)
num_updates=$(( $(echo $updates | wc -l) - 1))
if [[ $num_updates -eq 0 ]]; then
    dunstify "NO UPDATES"
else
    dunstify "UPDATES" "$updates" -t 5000
fi
