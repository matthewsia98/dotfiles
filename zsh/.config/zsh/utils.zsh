cutbuffer-to-system-clip () {
    if [ "${XDG_SESSION_TYPE}" = "wayland" ]
    then
        echo "${CUTBUFFER}" | wl-copy
    elif [ "${XDG_SESSION_TYPE}" = "x11" ]
    then
        echo "${CUTBUFFER}" | xclip -i -selection clipboard
    fi
}

paste-from-system-clip () {
    if [ "${XDG_SESSION_TYPE}" = "wayland" ]
    then
        RBUFFER=$(wl-paste)${RBUFFER}
    elif [ "${XDG_SESSION_TYPE}" = "x11" ]
    then
        RBUFFER=$(xclip -o -selection clipboard)${RBUFFER}
    fi
}

# Yank to the system clipboard
vi-yank-to-system-clip () {
    zle vi-yank
    cutbuffer-to-system-clip
}
zle -N vi-yank-to-system-clip

vi-yank-line-to-system-clip () {
    zle vi-yank-whole-line
    cutbuffer-to-system-clip
}
zle -N vi-yank-line-to-system-clip

vi-yank-eol-to-system-clip () {
    zle vi-yank-eol
    cutbuffer-to-system-clip
}
zle -N vi-yank-eol-to-system-clip

vi-delete-line-to-system-clip () {
    zle kill-whole-line
    cutbuffer-to-system-clip
}
zle -N vi-delete-line-to-system-clip

vi-delete-eol-to-system-clip () {
    zle vi-kill-eol
    cutbuffer-to-system-clip
}
zle -N vi-delete-eol-to-system-clip

# Paste from system clipboard
vi-paste-from-system-clip () {
    paste-from-system-clip
}
zle -N vi-paste-from-system-clip

ctrl-backspace () {
    if [[ "${LBUFFER}" = *"/"* ]]
    then
        curr_char="${LBUFFER[$CURSOR]}"
        if [[ "$curr_char" = "/" ]]
        then
            LBUFFER=${LBUFFER::-1}
        fi

        # Delete including /
        # LBUFFER=$(sed "s/\(.*\)\(\/.*\)/\1/" <<< "${LBUFFER}")

        # Delete excluding /
        LBUFFER=$(sed "s/\(.*\/\)\(.*\)/\1/" <<< "${LBUFFER}")
    else
        zle backward-kill-word
    fi
}
zle -N ctrl-backspace

# shellcheck disable=SC1009,SC1036,SC1056,SC1072,SC1073
clean-nvim () {
    sudo rm -r ${HOME}/.local/share/nvim
    sudo rm -r ${HOME}/.local/state/nvim/^(undo|shada)*
}

build-nvim () {
    tag="$1"
    if [[ "${tag}" == "" ]]
    then
        tag="master"
    fi

    cd ${HOME}/repos/neovim || return
    git checkout master
    git pull origin --tags --force
    git checkout "${tag}"
    sudo rm -rf ./build/
    sudo rm -rf /usr/local/share/nvim/runtime/
    sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
}

update-mirrorlist () {
    num="$1"
    if [[ "${num}" == "" ]]
    then
        num=10
    fi

    sudo reflector --country "Canada,United States" --latest "${num}" --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
}

set-hyprland-opacity () {
    program="$1"
    opacity="$2"
    if [[ "${program}" == "" || "${opacity}" == "" ]]
    then
        return
    fi

    sub="s/(^windowrule.*opacity\s*)([0-9]\.?[0-9]* [0-9]\.?[0-9]*)(.*${program}.*)/\1${opacity} ${opacity}\3/"
    sed -i.bak -E "$sub" "$HOME/.config/hypr/hyprland.conf"

    printf "Set opacity of %s to %s" "${program}" "${opacity}"
}
