function set_title() { 
	print -Pn "\e]0;%n@%m: %~\a" 
}
set_title

chpwd_functions+=(set_title)

export PATH=$HOME/.emacs.d/bin:$PATH
export BAT_THEME='OneHalfDark'
export EDITOR=vim
export VISUAL=vim
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
alias grep='grep --color=auto'
alias ls='lsd'
alias ll='lsd -alh'
alias cat='bat'
alias vim='nvim'
alias logout='loginctl terminate-user siam'
alias suspend='systemctl suspend'
alias emacs="emacsclient -c -a 'emacs'"
alias gs='git status'
alias ga='git add'
alias ga.='git add .'
alias gc='git commit -m'
alias gp='git push origin main'
alias pac='sudo pacman'


autoload -Uz compinit
compinit
#zstyle ':completion:*' menu select
zmodload zsh/complist


neofetch


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#00ffff,fg=#ff00ff,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)


# emacs mode
bindkey -v

#bindkey '\t' complete-word
bindkey '^ ' autosuggest-accept
bindkey '\t' menu-complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml
