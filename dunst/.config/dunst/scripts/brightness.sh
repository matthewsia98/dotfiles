#!/bin/sh

timeout=1000

if [[ $1 == "up" ]]
then
    brightnessctl -q s 5%+
elif [[ $1 == "down" ]]
then
    brightnessctl -q s 5%-
fi

curr_brightness=$(brightnessctl -q get)
max_brightness=$(brightnessctl -q max)
brightness=$(( curr_brightness * 100 / max_brightness ))
notify-send \
    -a "Brightness" \
    "Currently at ${brightness}%" \
    -h string:x-dunst-stack-tag:brightness \
    -i ~/.config/dunst/assets/brightness.svg \
    -h int:value:"$brightness" \
    -t $timeout
