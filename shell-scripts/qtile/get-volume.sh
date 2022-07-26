#!/bin/zsh
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E '([0-9]*)%' | head -1)
printf '%s%s%s' '[' $volume ']'
