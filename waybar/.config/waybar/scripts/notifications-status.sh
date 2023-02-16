#!/bin/sh

muted_symbol=""
unmuted_symbol=""

paused=$(dunstctl is-paused)
if [[ "${paused}" = "true" ]]
then
	count_waiting=$(dunstctl count waiting)
    printf "${muted_symbol}  ${count_waiting}"
else
    printf "${unmuted_symbol}"
fi
