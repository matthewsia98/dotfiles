#!/bin/sh

id=998
timeout=1000

if [[ $1 == "up" ]]
then
    title="Increase"
    brightnessctl -q s 5%+
elif [[ $1 == "down" ]]
then
    title="Decrease"
    brightnessctl -q s 5%-
fi

curr_brightness=$(brightnessctl -q get)
max_brightness=$(brightnessctl -q max)
brightness=$(( curr_brightness * 100 / max_brightness ))
notify-send \
    -a "$title" \
    "Brightness: ${brightness}%" \
    -i ~/.config/dunst/assets/brightness.svg \
    -r "$id" \
    -h int:value:"$brightness" \
    -t $timeout
