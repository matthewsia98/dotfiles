function set_title() { 
	print -Pn "\e]0;%n@%m: %~\a" 
}
set_title

chpwd_functions+=(set_title)

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

function toggle_keymap() {
    local variant=$(setxkbmap -query | awk '/variant:/ {print $2}')
    if [[ $variant = '' ]] then
        setxkbmap us colemak_dh
    else
        setxkbmap us
    fi
    xmodmap ~/.Xmodmap
}

PROMPT_EOL_MARK=""

# Environment Variables
export PATH=$PATH:~/.local/bin
export BAT_THEME='OneHalfDark'
export EDITOR='nvim'
export VISUAL='nvim'
export HISTFILE=~/.zsh_history
# Session History
export HISTSIZE=100000
# Max history file size
export SAVEHIST=1000000000

# Add to history immediately, not on exit
setopt INC_APPEND_HISTORY

# Add timestamps
export HISTTIMEFORMAT='[%F %T]'
setopt EXTENDED_HISTORY

setopt HIST_IGNORE_ALL_DUPS


# Prompt
ZLE_RPROMPT_INDENT=0
#PS1='%F{cyan}%~ > %f'
#RPS1='[%*]'


# Aliases
# Shell
alias ..='cd ..'
alias hg='history 1 | grep'
alias grep='grep --color=auto'
alias ls='lsd'
alias ll='lsd -alh'
alias lll='lsd -alhL'
alias cp='cp -rv'
alias mkdir='mkdir -pv'
alias cat='bat'
alias rg='rg -S'
alias tree='tree -CF'
alias logout='loginctl terminate-user $USER'
alias suspend='systemctl suspend'

# Programs
alias vi='nvim'
alias vim='nvim'
alias feh='feh --scroll-step 20 --zoom-step 5 --scale-down -d -g 1900x980 --info "echo %wx%h" --image-bg #494D54 -C ~/.fonts -e static/RobotoMono-Bold/20'
alias conky="conky -c ~/.config/conky/process.conf"
alias uotp='python ~/Misc/uottawa_otp.py'

# Git
alias gcl='git clone'
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit -m'
alias gpl='git pull'
alias gp='git push'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias grm='git rm -r --cached'
alias gRM='git rm -r'
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit'

# Pacman
alias pac='sudo pacman'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -R'
alias pacsyu='sudo pacman -Syu'
alias pacg='pacman -Q | grep'
alias pacls='pacman -Q'


# Autosuggest and Syntax highlighting
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#494D64,fg=#CAD3F5,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# source ~/repos/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Key Bindings
# Shell emacs/vim mode
bindkey -v

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


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml


# FZF
local fzf_cmd='find -L'
local fzf_opts='--height 60% --layout=reverse --border --multi --info=inline --header=""'
# local fzf_opts='--height 60% --layout=reverse --border --multi --info=inline --header="" --color bg:#24273A,fg:#CAD3F5,preview-bg:#24273A,preview-fg:#CAD3F5,bg+:#494D64,fg+:#CAD3F5,gutter:#24273A,border:#B7BDF8,hl:#A6DA95,hl+:#A6DA95,pointer:#CAD3F5,info:#CAD3F5'
export FZF_COMPLETION_TRIGGER='*'
export FZF_COMPLETION_OPTS=$fzf_opts
export FZF_DEFAULT_COMMAND=$fzf_cmd
export FZF_CTRL_T_COMMAND=$fzf_cmd
# export FZF_DEFAULT_OPTS=$fzf_opts

# Latte
local latte=" \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

# Frappe
local frappe=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# Macchiato
local macchiato=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Mocha
local mocha=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_DEFAULT_OPTS="$fzf_opts $mocha"

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


# Node Version Manager
source /usr/share/nvm/init-nvm.sh


# neofetch --ascii ~/.config/neofetch/ascii/bat_ascii --ascii_colors 4
# pfetch
colorscript -r
export PATH=$PATH:/home/msia/.spicetify
