#!/bin/sh

muted_symbol=""
unmuted_symbol=""

paused=$(dunstctl is-paused)
if [[ "$paused" = "true" ]]
then
    printf "$muted_symbol"
else
    printf "$unmuted_symbol"
fi
