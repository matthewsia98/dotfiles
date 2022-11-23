#!/bin/zsh
MUTE_ICON=""
UNMUTE_ICON=""
PLUS_ICON=""
MINUS_ICON=""

if [[ $1 == "mute" ]]
then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    mute=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [[ $mute = *"yes"* ]]
    then
        dunstify -h string:x-dunst-stack-tag:audio "$MUTE_ICON Muted" -t 3000
        # dunstify -h string:x-dunst-stack-tag:audio -i "/usr/share/icons/Papirus/16x16/actions/audio-volume-muted.svg" "Muted" -t 3000
    else
        dunstify -h string:x-dunst-stack-tag:audio "$UNMUTE_ICON Unmuted" -t 3000
    fi
elif [[ $1 == "raise" ]]
then
    mute=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [[ $mute = *"yes"* ]]
    then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E "([0-9]*)%" | head -1)
    volume=${volume::-1}
    dunstify -h string:x-dunst-stack-tag:audio "$PLUS_ICON Volume: [$volume%]" -h int:value:"$volume" -t 3000
    # dunstify -h string:x-dunst-stack-tag:audio -i "/usr/share/icons/Papirus/16x16/actions/audio-volume-high.svg" "Volume: [$volume%]" -h int:value:"$volume" -t 3000
elif [[ $1 == "lower" ]]
then
    mute=$(pactl get-sink-mute @DEFAULT_SINK@)
    if [[ $mute = *"yes"* ]]
    then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o -E "([0-9]*)%" | head -1)
    volume=${volume::-1}
    dunstify -h string:x-dunst-stack-tag:audio "$MINUS_ICON Volume: [$volume%]" -h int:value:"$volume" -t 3000
    # dunstify -h string:x-dunst-stack-tag:audio -i "/usr/share/icons/Papirus/16x16/actions/audio-volume-high.svg" "Volume: [$volume%]" -h int:value:"$volume" -t 3000
fi
