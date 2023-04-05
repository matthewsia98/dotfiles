#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "${SELECTED}" = "true" ]; then
	sketchybar --set "${NAME}" icon.font.size=18.0 icon.color=0xfff9e2af
else
	sketchybar --set "${NAME}" icon.font.size=12.0 icon.color=0xffcdd6f4
fi
