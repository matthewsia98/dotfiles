#!/bin/zsh

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
            -h string:x-dunst-stack-tag:audio \
            -i ~/.config/dunst/assets/volume-mute.svg \
            -t $timeout
    else
        notify-send \
            -a "Volume" \
            "Unmuted" \
            -h string:x-dunst-stack-tag:audio \
            -i ~/.config/dunst/assets/volume.svg \
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
        pactl set-sink-volume @DEFAULT_SINK@ +5%
    elif [[ $1 == "lower" ]]
    then
        pactl set-sink-volume @DEFAULT_SINK@ -5%
    fi

    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E "([0-9]*)%" | head -1)
    volume=${volume::-1}
    notify-send \
        -a "Volume" \
        "Currently at ${volume}%" \
        -h string:x-dunst-stack-tag:audio \
        -i ~/.config/dunst/assets/volume.svg \
        -h int:value:"$volume" \
        -t $timeout
fi
