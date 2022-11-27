#!/bin/zsh
ICON=""

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
# dunstify -h string:x-dunst-stack-tag:brightness -i "/usr/share/icons/Papirus/16x16/actions/brightnesssettings.svg" "Brightness: [$brightness%]" -h int:value:"$brightness" -t 3000
dunstify -h string:x-dunst-stack-tag:brightness "$ICON Brightness: [$brightness%]" -h int:value:"$brightness" -t 3000
