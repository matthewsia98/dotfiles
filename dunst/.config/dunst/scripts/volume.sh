#!/bin/sh

id=999
timeout=1000

if [[ $1 == "mute" ]]
then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    mute=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [[ $mute = *"yes"* ]]
    then
        notify-send \
            -a "Volume" \
            "Muted" \
            -i ~/.config/dunst/assets/volume-mute.svg \
            -r "$id" \
            -t $timeout
    else
        notify-send \
            -a "Volume" \
            "Unmuted" \
            -i ~/.config/dunst/assets/volume.svg \
            -r "$id" \
            -t $timeout
    fi
else
    mute=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [[ $mute = *"yes"* ]]
    then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi

    if [[ $1 == "raise" ]]
    then
        title="Increase"
        pactl set-sink-volume @DEFAULT_SINK@ +5%
    elif [[ $1 == "lower" ]]
    then
        title="Decrease"
        pactl set-sink-volume @DEFAULT_SINK@ -5%
    fi

    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E "([0-9]*)%" | head -1)
    volume=${volume::-1}
    notify-send \
        -a "$title" \
        "Volume: ${volume}%" \
        -i ~/.config/dunst/assets/volume.svg \
        -r "$id" \
        -h int:value:"$volume" \
        -t $timeout
fi
