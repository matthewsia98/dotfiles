set_title () { 
	print -Pn "\e]0;%n@%m: %~\a" 
}

toggle_program () {
    program="$1"
    c1=${program:0:1}
    c2=${program:1:#program}
    running=$(pgrep "[$c1]$c2")

    if [ "$running" = "" ] ; then
        $program
    else
        killall "$program"
    fi
}

# Yank to the system clipboard
vi_yank () {
    if [ "$XDG_SESSION_TYPE" = "wayland" ]
    then
        echo "$CUTBUFFER" | wl-copy
    elif [ "$XDG_SESSION_TYPE" = "x11" ]
    then
        echo "$CUTBUFFER" | xclip -i -selection clipboard
    fi
}
zle -N vi_yank

# Paste from system clipboard
vi_paste () {
    if [ "$XDG_SESSION_TYPE" = "wayland" ]
    then
        RBUFFER=$(wl-paste)$RBUFFER
    elif [ "$XDG_SESSION_TYPE" = "x11" ]
    then
        RBUFFER=$(xclip -o -selection clipboard)$RBUFFER
    fi
}
zle -N vi_paste

toggle_keymap () {
    variant=$(setxkbmap -query | awk "/variant:/ {print $2}")
    if [ "$variant" = "" ]
    then
        setxkbmap us colemak_dh
    else
        setxkbmap us
    fi
    xmodmap ~/.Xmodmap
}
