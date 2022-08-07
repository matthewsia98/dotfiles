function set_title() { 
	print -Pn "\e]0;%n@%m: %~\a" 
}
set_title

chpwd_functions+=(set_title)

export PATH=$HOME/lua-language-server/bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH
export BAT_THEME='OneHalfDark'
#export EDITOR='vim'
#export VISUAL='vim'
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -c -a emacs'
export HISTFILE=~/.zsh_history
# Session History
export HISTSIZE=1000
# Max history file size
export SAVEHIST=10000

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
alias logout='loginctl terminate-user siam'
alias suspend='systemctl suspend'

# Programs
alias vim='nvim -u ~/.config/nvim/init.lua'
alias emacs="emacsclient -c -a 'emacs'"

# Git
alias gcl='git clone'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gco='git checkout'
alias gd='git diff'

# Pacman
alias pac='sudo pacman'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -R'
alias pacsyu='sudo pacman -Syu'
alias pacg='pacman -Q | grep'
alias paclist='pacman -Q'


autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zmodload zsh/complist


# neofetch


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#00ffff,fg=#ff00ff,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


# Shell emacs/vim mode
bindkey -e

#bindkey '\t' complete-word
bindkey '^ ' autosuggest-accept
bindkey '\t' menu-complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

alias luamake=/home/siam/lua-language-server/3rd/luamake/luamake
