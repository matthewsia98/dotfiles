function set_title() { 
	print -Pn "\e]0;%n@%m: %~\a" 
}
set_title

chpwd_functions+=(set_title)

function toggle_keymap() {
    local variant=$(setxkbmap -query | awk '/variant:/ {print $2}')
    if [[ $variant = '' ]] then
        setxkbmap us colemak_dh
    else
        setxkbmap us
    fi
    xmodmap ~/.Xmodmap
}

export PATH=$PATH:~/.local/bin
export BAT_THEME='OneHalfDark'
export EDITOR='nvim'
export VISUAL='nvim'
export HISTFILE=~/.zsh_history
# Session History
export HISTSIZE=10000
# Max history file size
export SAVEHIST=1000000

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT='[%F %T]'
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

ZLE_RPROMPT_INDENT=0

#PS1='%F{cyan}%~ > %f'
#RPS1='[%*]'


# Aliases
# Zsh
alias ..='cd ..'
alias hg='history 1 | grep'
alias grep='grep --color=auto'
alias ls='lsd'
alias ll='lsd -alh'
alias mkdir='mkdir -pv'
alias cat='bat'
alias logout='loginctl terminate-user $USER'
alias suspend='systemctl suspend'

# Programs
alias vi='nvim'
alias vim='nvim'
alias feh='feh --scale-down -d -g 1800x1020+60+10 --info "echo %wx%h" --image-bg #494D54 -C ~/.fonts -e static/RobotoMono-Bold/20'
alias conky="conky -c ~/.config/conky/process.conf"

# Git
alias gcl='git clone'
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit -m'
alias gpl='git pull'
alias gp='git push'
alias gco='git checkout'
alias gd='git diff'

# Pacman
alias pac='sudo pacman'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -R'
alias pacsyu='sudo pacman -Syu'
alias pacg='pacman -Q | grep'
alias pacls='pacman -Q'


autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zmodload zsh/complist


# neofetch


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#494D64,fg=#CAD3F5,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


# Shell emacs/vim mode
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
   zle vi-yank
   echo "$CUTBUFFER" | xclip -i -selection clipboard
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Paste from system clipboard
function vi-paste-xclip () {
    RBUFFER=$(xclip -o -selection clipboard)$RBUFFER
}
zle -N vi-paste-xclip
bindkey -M vicmd 'p' vi-paste-xclip

bindkey '^?' backward-delete-char
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search

# bindkey '\t' complete-word
bindkey '^ ' autosuggest-accept
bindkey '\t' menu-complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml


# FZF
local fzf_cmd='find -L'
local fzf_opts='--height 60% --layout=reverse --border --multi --info=inline --header="" --color bg:#24273A,fg:#CAD3F5,preview-bg:#24273A,preview-fg:#CAD3F5,bg+:#494D64,fg+:#CAD3F5,gutter:#24273A,border:#B7BDF8,hl:#A6DA95,hl+:#A6DA95,pointer:#CAD3F5,info:#CAD3F5'
export FZF_COMPLETION_TRIGGER='*'
export FZF_COMPLETION_OPTS=$fzf_opts
export FZF_DEFAULT_COMMAND=$fzf_cmd
export FZF_CTRL_T_COMMAND=$fzf_cmd
export FZF_DEFAULT_OPTS=$fzf_opts

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
