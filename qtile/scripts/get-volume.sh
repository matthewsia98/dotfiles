#!/bin/zsh
muted=$(pactl get-sink-mute @DEFAULT_SINK@)
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E '([0-9]*)%' | head -1)

if [[ $muted = *"yes"* ]] || [[ $volume == '0%' ]]
then
    print -1
else
    printf '%s%s%s' '[' $volume ']'
fi
