#!/bin/zsh

updates=$(checkupdates)
n=$(echo "$updates" | wc -l)
dunstify "$updates" -t $((n * 1000))
