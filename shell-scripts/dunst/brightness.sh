#!/bin/zsh

if [[ $1 == "raise" ]]
then
    brightnessctl s 5%+
elif [[ $1 == "lower" ]]
then
    brightnessctl s 5%-
fi

curr_brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness=$(( curr_brightness * 100 / max_brightness ))
dunstify -h string:x-dunst-stack-tag:brightness "Brightness: [$brightness%]" -h int:value:"$brightness" -t 1500
