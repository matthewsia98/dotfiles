cutbuffer-to-system-clip () {
    if [ "${XDG_SESSION_TYPE}" = "wayland" ]
    then
        echo "${CUTBUFFER}" | wl-copy
    elif [ "${XDG_SESSION_TYPE}" = "x11" ]
    then
        echo "${CUTBUFFER}" | xclip -i -selection clipboard
    elif [ "$(uname)" = "Darwin" ]
    then
        echo "${CUTBUFFER}" | pbcopy
    fi
}

paste-from-system-clip () {
    if [ "${XDG_SESSION_TYPE}" = "wayland" ]
    then
        RBUFFER=$(wl-paste)${RBUFFER}
    elif [ "${XDG_SESSION_TYPE}" = "x11" ]
    then
        RBUFFER=$(xclip -o -selection clipboard)${RBUFFER}
    elif [ "$(uname)" = "Darwin" ]
    then
        RBUFFER=$(pbpaste)${RBUFFER}
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
        if [[ "${curr_char}" = "/" ]]
        then
            LBUFFER="${LBUFFER[1,-2]}"
        fi

        # Delete including /
        # LBUFFER=$(sed "s/\(.*\)\(\/.*\)/\1/" <<< "${LBUFFER}")

        # Delete excluding /
        LBUFFER="$(sed "s/\(.*\/\)\(.*\)/\1/" <<< "${LBUFFER}")"
    else
        zle backward-kill-word
    fi
}
zle -N ctrl-backspace

clean-nvim () {
    sudo rm -rv ${HOME}/.local/share/${NVIM_APPNAME}
    sudo rm -rv ${HOME}/.local/state/${NVIM_APPNAME}/^(undo|shada)*
}

build-nvim () {
    tag="${1:-"master"}"
    pushd ${HOME}/repos/neovim
    git checkout master
    git pull origin --tags --force
    git checkout "${tag}"
    sudo rm -rf ./build/
    sudo rm -rf /usr/local/share/nvim/runtime/
    sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
    popd
}

update-mirrorlist () {
    num="${1:-10}"
    sudo reflector --country "Canada,United States" --latest "${num}" --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
}

hyprland-set-opacity () {
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

hyprland-toggle-swallow () {
    current=$(hyprctl getoption -j misc:enable_swallow | jq -r ".int")
    new=$(( 1 - current ))
    msg=$([[ "${new}" == 1 ]] && echo "Enabled swallow" || echo "Disabled swallow")
    hyprctl keyword misc:enable_swallow "${new}" && notify-send -r 991 -a "Hyprland" "${msg}"
}

mac-os-open () {
    if [ -f "$1" ]
    then
        filetype=$(file -b --mime-type "$1")
        if [ "${filetype}" = "text/plain" ]
        then
            nvim "$1"
            return
        fi

        case "$1" in
            *.pdf) zathura "$1" ;;
            *) open "$1" ;;
        esac
    fi
}

yabai-visudo () {
    echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
}
