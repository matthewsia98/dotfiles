#!/bin/zsh

num_updates=$(checkupdates | wc -l)
if [[ $num_updates -eq 0 ]]; then
    notify-send \
        -a "Updates" \
        "No Updates" \
        -i ~/.config/dunst/assets/bell.svg \
        -t 1000
else
    updates=$(checkupdates)
    notify-send \
        -a "Updates" \
        "${updates}" \
        -i /dev/null \
        -t 3000
fi
