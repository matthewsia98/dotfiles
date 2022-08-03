#!/bin/zsh

if [[ $1 == "mute" ]]
then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [[ $1 == "raise" ]]
then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
elif [[ $1 == "lower" ]]
then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

mute=$(pactl get-sink-mute @DEFAULT_SINK@)
if [[ $mute = *"yes"* ]]
then
    is_muted=1
else
    is_muted=0
fi

if [[ $is_muted -eq 1 ]]
then
    dunstify -h string:x-dunst-stack-tag:audio -i "/usr/share/icons/Papirus-Dark/16x16/actions/audio-volume-muted.svg" "Muted" -t 3000
else
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E "([0-9]*)%" | head -1)
    volume=${volume::-1}
    dunstify -h string:x-dunst-stack-tag:audio -i "/usr/share/icons/Papirus-Dark/16x16/actions/audio-volume-high.svg" "Volume: [$volume%]" -h int:value:"$volume" -t 3000
fi
