[ -f ~/.config/zsh/functions ] && source ~/.config/zsh/functions
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases

# lets files beginning with a . be matched without explicitly specifying the dot
# setopt globdots

setopt extendedglob


########################################################
#  
#  ██████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ████████╗
#  ██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝
#  ██████╔╝██████╔╝██║   ██║██╔████╔██║██████╔╝   ██║   
#  ██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔═══╝    ██║   
#  ██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║██║        ██║   
#  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝        ╚═╝   
#  
########################################################
# Disable % if line doesn"t end with \n
PROMPT_EOL_MARK=""

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml


###################################################################
#  
#  ███████╗███╗   ██╗██╗   ██╗    ██╗   ██╗ █████╗ ██████╗ ███████╗
#  ██╔════╝████╗  ██║██║   ██║    ██║   ██║██╔══██╗██╔══██╗██╔════╝
#  █████╗  ██╔██╗ ██║██║   ██║    ██║   ██║███████║██████╔╝███████╗
#  ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝    ╚██╗ ██╔╝██╔══██║██╔══██╗╚════██║
#  ███████╗██║ ╚████║ ╚████╔╝      ╚████╔╝ ██║  ██║██║  ██║███████║
#  ╚══════╝╚═╝  ╚═══╝  ╚═══╝        ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
#  
###################################################################
export PATH=$PATH:~/.local/bin:~/.cargo/bin:~/.spicetify
export PATH=$PATH:~/.local/share/nvim/mason/bin

export EDITOR="nvim"
export VISUAL="nvim"
export PSQL_EDITOR="nvim"

export HISTFILE=~/.zsh_history
# Session History
export HISTSIZE=100000
# Max history file size
export SAVEHIST=1000000000
# Add timestamps
export HISTTIMEFORMAT="[%F %T]"

export EXA_COLORS="*.png=35"

# Add to history immediately, not on exit
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS


######################################################################################
#  
#   ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗██╗ ██████╗ ███╗   ██╗
#  ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
#  ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   ██║██║   ██║██╔██╗ ██║
#  ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██║██║   ██║██║╚██╗██║
#  ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ██║╚██████╔╝██║ ╚████║
#   ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
#  
######################################################################################
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#494D64,fg=#CAD3F5,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zmodload zsh/complist
autoload -Uz compinit && compinit
zstyle ":completion:*" menu select


##############################################################################################
#  
#  ███████╗██╗   ██╗███████╗███████╗██╗   ██╗    ███████╗██╗███╗   ██╗██████╗ ███████╗██████╗ 
#  ██╔════╝██║   ██║╚══███╔╝╚══███╔╝╚██╗ ██╔╝    ██╔════╝██║████╗  ██║██╔══██╗██╔════╝██╔══██╗
#  █████╗  ██║   ██║  ███╔╝   ███╔╝  ╚████╔╝     █████╗  ██║██╔██╗ ██║██║  ██║█████╗  ██████╔╝
#  ██╔══╝  ██║   ██║ ███╔╝   ███╔╝    ╚██╔╝      ██╔══╝  ██║██║╚██╗██║██║  ██║██╔══╝  ██╔══██╗
#  ██║     ╚██████╔╝███████╗███████╗   ██║       ██║     ██║██║ ╚████║██████╔╝███████╗██║  ██║
#  ╚═╝      ╚═════╝ ╚══════╝╚══════╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═╝
#  
##############################################################################################
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
    exa -aT --icons --color=always {}
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


# FZF-TAB
zstyle ':fzf-tab:*' fzf-flags '--height=80%'

# set descriptions format to enable group support
zstyle ":completion:*:descriptions" format "[%d]"
# set list-colors to enable filename colorizing
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

# disable or override preview for command options and subcommands
zstyle ':fzf-tab:complete:*:options' fzf-preview
# zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

fzf_tab_preview="${fzf_preview}"
fzf_tab_preview=$(sed 's/{}/${realpath}/g' <<< "${fzf_tab_preview}")

zstyle ':fzf-tab:complete:*' fzf-preview "${fzf_tab_preview}"

# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

zstyle ':fzf-tab:complete:-command-:*' fzf-preview '\
    (out=$(tldr --color always "$word") 2>/dev/null && echo $out) || 
    (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || 
    (out=$(which "$word") && echo $out) || 
    echo "${(P)word}"'

zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview '\
	case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview '\
	case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

zstyle ":fzf-tab:*" continuous-trigger "/"
zstyle ":fzf-tab:*" switch-group "ctrl-h" "ctrl-l"

[ -f ~/repos/fzf-tab/fzf-tab.plugin.zsh ] && source ~/repos/fzf-tab/fzf-tab.plugin.zsh


[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh ] && source ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh


#####################################################################
#  
#  ██╗  ██╗███████╗██╗   ██╗    ██████╗ ██╗███╗   ██╗██████╗ ███████╗
#  ██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██╔══██╗██║████╗  ██║██╔══██╗██╔════╝
#  █████╔╝ █████╗   ╚████╔╝     ██████╔╝██║██╔██╗ ██║██║  ██║███████╗
#  ██╔═██╗ ██╔══╝    ╚██╔╝      ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║
#  ██║  ██╗███████╗   ██║       ██████╔╝██║██║ ╚████║██████╔╝███████║
#  ╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝
#  
#####################################################################
# Shell emacs/vim mode
bindkey -v

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line

bindkey "^h" ctrl-backspace
bindkey "^?" backward-delete-char
bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search

bindkey '^Xh' _complete_help
# bindkey "\t" complete-word
bindkey "^ " autosuggest-accept
# bindkey "\t" menu-complete

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history

bindkey -M vicmd "y" vi-yank-to-system-clip
bindkey -M vicmd "yy" vi-yank-line-to-system-clip
bindkey -M vicmd "Y" vi-yank-eol-to-system-clip
bindkey -M vicmd "dd" vi-delete-line-to-system-clip
bindkey -M vicmd "D" vi-delete-eol-to-system-clip
bindkey -M vicmd "p" vi-paste-from-system-clip


#############################################################################################################
#  
#  ███╗   ███╗██╗███████╗ ██████╗███████╗██╗     ██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗███████╗
#  ████╗ ████║██║██╔════╝██╔════╝██╔════╝██║     ██║     ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔════╝
#  ██╔████╔██║██║███████╗██║     █████╗  ██║     ██║     ███████║██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████╗
#  ██║╚██╔╝██║██║╚════██║██║     ██╔══╝  ██║     ██║     ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║██║   ██║╚════██║
#  ██║ ╚═╝ ██║██║███████║╚██████╗███████╗███████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝╚██████╔╝███████║
#  ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝
#  
#############################################################################################################
# Node Version Manager
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# colorscript -r

# neofetch
# neofetch --ascii ~/.config/neofetch/ascii/bat_ascii --ascii_colors 4
# pfetch
nitch
