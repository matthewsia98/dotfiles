#!/bin/sh

tmp_path=/tmp/hypr/toggle_rounding

rounding=$(hyprctl getoption decoration:rounding | awk '/int/ { print $2 }')

if [ ! -f $tmp_path ]
then
    echo "rounding: $rounding" >> $tmp_path
fi

if [ $rounding -eq 0 ]
then
    rounding=$(awk '/rounding/ { print $2 }' $tmp_path)
    hyprctl keyword decoration:rounding $rounding
else
    hyprctl keyword decoration:rounding 0
fi
