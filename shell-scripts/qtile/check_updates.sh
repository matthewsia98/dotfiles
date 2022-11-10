#!/bin/zsh

updates=$(pacman -Qu)
dunstify "Updates" "$updates" -t 3000
