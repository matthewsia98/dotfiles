#!/bin/zsh

updates=$(checkupdates)
dunstify "UPDATES" "$updates" -t 5000
