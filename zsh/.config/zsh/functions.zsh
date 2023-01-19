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
vi-yank-to-system-clip () {
    zle vi-yank

    if [ "$XDG_SESSION_TYPE" = "wayland" ]
    then
        echo "$CUTBUFFER" | wl-copy
    elif [ "$XDG_SESSION_TYPE" = "x11" ]
    then
        echo "$CUTBUFFER" | xclip -i -selection clipboard
    fi
}
zle -N vi-yank-to-system-clip
vi-yank-line-to-system-clip () {
    zle vi-yank-whole-line

    if [ "$XDG_SESSION_TYPE" = "wayland" ]
    then
        echo "$CUTBUFFER" | wl-copy
    elif [ "$XDG_SESSION_TYPE" = "x11" ]
    then
        echo "$CUTBUFFER" | xclip -i -selection clipboard
    fi
}
zle -N vi-yank-line-to-system-clip

# Paste from system clipboard
vi-paste-from-system-clip () {
    if [ "$XDG_SESSION_TYPE" = "wayland" ]
    then
        RBUFFER=$(wl-paste)$RBUFFER
    elif [ "$XDG_SESSION_TYPE" = "x11" ]
    then
        RBUFFER=$(xclip -o -selection clipboard)$RBUFFER
    fi
}
zle -N vi-paste-from-system-clip

ctrl-backspace () {
    curr_char="$LBUFFER[$CURSOR]"
    if [[ "$curr_char" = "/" ]]
    then
        LBUFFER=${LBUFFER::-1}
    fi

    # Delete including /
    LBUFFER=$(sed "s/\(.*\)\(\/.*\)/\1/" <<< "$LBUFFER")

    # Delete excluding /
    # LBUFFER=$(sed "s/\(.*\/\)\(.*\)/\1/" <<< "$LBUFFER")
}
zle -N ctrl-backspace
