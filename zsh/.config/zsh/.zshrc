source ~/.config/zsh/functions.zsh
source ~/.config/zsh/aliases
# set_title
# chpwd_functions+=(set_title)


setopt globdots


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
# PS1="%F{cyan}%~ > %f"
# RPS1="[%*]"
# Remove right prompt indent
# ZLE_RPROMPT_INDENT=0
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

autoload -Uz compinit
compinit
zstyle ":completion:*" menu select
zmodload zsh/complist

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh


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
local fzf_cmd="find -L"
local fzf_opts="--height 60% --layout=reverse --border --multi --info=inline --header="""
# local fzf_opts="--height 60% --layout=reverse --border --multi --info=inline --header="" --color bg:#24273A,fg:#CAD3F5,preview-bg:#24273A,preview-fg:#CAD3F5,bg+:#494D64,fg+:#CAD3F5,gutter:#24273A,border:#B7BDF8,hl:#A6DA95,hl+:#A6DA95,pointer:#CAD3F5,info:#CAD3F5"
export FZF_COMPLETION_TRIGGER="*"
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

kernel=$(uname -r)
if [[ $kernel = *"WSL2"* ]]
then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
else
    source /usr/share/fzf/key-bindings.zsh
fi

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# FZF-TAB
source ~/repos/fzf-tab/fzf-tab.plugin.zsh
# disable sort when completing `git checkout`
zstyle ":completion:*:git-checkout:*" sort false
# set descriptions format to enable group support
zstyle ":completion:*:descriptions" format "[%d]"
# set list-colors to enable filename colorizing
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
# preview directory"s content with exa when completing cd
zstyle ":fzf-tab:complete:cd:*" fzf-preview "exa -1 --color=always $realpath"
# switch group using `,` and `.`
# zstyle ":fzf-tab:*" switch-group "," "."
zstyle ":fzf-tab:*" fzf-min-height 8


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

# bindkey "^h" vi-backward-kill-word
bindkey -s "^h" "^[dF/xa"
bindkey "^?" backward-delete-char
bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search

# bindkey "\t" complete-word
bindkey "^ " autosuggest-accept
# bindkey "\t" menu-complete

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history

bindkey -M vicmd "y" vi-yank-to-system-clip
bindkey -M vicmd "yy" vi-yank-line-to-system-clip
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
source /usr/share/nvm/init-nvm.sh

# neofetch
# neofetch --ascii ~/.config/neofetch/ascii/bat_ascii --ascii_colors 4
pfetch
# colorscript -r
