LOGFILE=.xsession-log
echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Running .xsession' > $LOGFILE

xrandr --output eDP-1 --mode 1920x1080
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Starting picom' >> $LOGFILE
picom -b 2>> $LOGFILE
echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Started picom' >> $LOGFILE

echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Starting sxhkd' >> $LOGFILE
sxhkd & 2>> $LOGFILE
echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Started sxhkd' >> $LOGFILE

echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Starting libinput-gestures' >> $LOGFILE
libinput-gestures-setup start 2>> $LOGFILE
echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Started libinput-gestures' >> $LOGFILE

# echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Starting qtile' >> $LOGFILE
# qtile start -c ~/.config/qtile/config.py 2>> $LOGFILE
# echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Started qtile' >> $LOGFILE

# echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Starting awesome' >> $LOGFILE
# awesome 2>> $LOGFILE
# echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Started awesome' >> $LOGFILE

echo $(date +'[%b %e %Y %H:%M:%S %Z]') 'Finished running xession' >> $LOGFILE
