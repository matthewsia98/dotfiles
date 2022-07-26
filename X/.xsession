echo 'Running xsession' > xsession-output
xrandr --output eDP-1 --mode 1920x1080
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
/usr/bin/emacs --daemon
picom --experimental-backends -b
