#!/bin/zsh
if pgrep -x 'picom' > /dev/null
then
    killall picom
    echo '0'
else
    picom --experimental-backends -b
    echo '1'
fi
