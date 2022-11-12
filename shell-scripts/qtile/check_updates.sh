#!/bin/zsh

updates=$(checkupdates)
n=$(echo "$updates" | wc -l)
dunstify "UPDATES" "$updates" -t $((n * 1000))
