# fzf_cmd="find -L 2>/dev/null"
# fzf_cmd='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name '\''*.tags'\'' -printf '\''%P\n'\'
# fzf_cmd="rg -L --files --hidden -g '!.git'"

# fuzzy completion always
export FZF_COMPLETION_TRIGGER="**"

# export FZF_DEFAULT_COMMAND="${fzf_cmd}"
# export FZF_CTRL_T_COMMAND="${fzf_cmd}"
# export FZF_ALT_C_COMMAND="${fzf_cmd}"

mocha="\
--color=border:#89b4fa \
--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#89b4fa,pointer:#cdd6f4 \
--color=marker:#cdd6f4,fg+:#cdd6f4,prompt:#89b4fa,hl+:#f38ba8"

fzf_opts="\
--ansi --multi --cycle --height=80% --border=rounded --info=inline --layout=reverse --header='' --separator='' --pointer='>' --marker='> ' \
--bind='ctrl-space:toggle,ctrl-f:preview-down,ctrl-b:preview-up,ctrl-/:change-preview-window(right,70%|hidden|right)' \
${mocha}"

fzf_preview='
if [ -f {} ]
then
    case {} in
        *.pdf)
            pdftotext {} - || bat -n --color=always
            ;;
        *.md)
            glow -s dark {}
            ;;
        *.zip)
            zipinfo {}
            ;;
        *.png | *.jpg | *.jpeg)
            # chafa --format=kitty --size=50x30 {}
            file {}
            ;;
        *.mp3 | *.mp4 | *.mkv | *.avi)
            mediainfo {}
            ;;
        *)
            if [ $(file -b --mime-encoding {} | grep binary) ]
            then
                hexdump -C {}
            else
                bat -n --color=always {}
            fi
            ;;
    esac
elif [ -d {} ]
then
    exa -aT --icons --color=always $(realpath {})
fi'

export FZF_DEFAULT_OPTS="${fzf_opts}"
export FZF_COMPLETION_OPTS="${fzf_opts} --preview='${fzf_preview}'"
export FZF_CTRL_T_OPTS="${fzf_opts} --preview='${fzf_preview}'"
export FZF_ALT_C_OPTS="${fzf_opts} --preview='${fzf_preview}'"

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

bindkey -M vicmd "^T" fzf-file-widget
bindkey -M viins "^T" fzf-file-widget
bindkey -M vicmd "^R" fzf-history-widget
bindkey -M viins "^R" fzf-history-widget
bindkey -M vicmd "\ec" fzf-cd-widget
bindkey -M viins "\ec" fzf-cd-widget
