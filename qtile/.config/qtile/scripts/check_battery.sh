#!/bin/zsh
info=$(upower -i $(upower -e | grep 'BAT') | grep -A 12 -e 'state' | awk '{$1=$1;print}')
dunstify "$info" -t 5000
