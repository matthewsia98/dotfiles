[ -f ~/.config/zsh/utils.zsh ] && source ~/.config/zsh/utils.zsh
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases
[ -f ~/.config/zsh/options.zsh ] && source ~/.config/zsh/options.zsh
[ -f ~/.config/zsh/environment.zsh ] && source ~/.config/zsh/environment.zsh
[ -f ~/.config/zsh/keybinds.zsh ] && source ~/.config/zsh/keybinds.zsh

# Disable % if line doesn"t end with \n
PROMPT_EOL_MARK=""

# Starship
eval "$(starship init zsh)"

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#494D64,fg=#CAD3F5,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zmodload zsh/complist
autoload -Uz compinit && compinit
[ -f ~/.config/zsh/fzf.zsh ] && source ~/.config/zsh/fzf.zsh
[ -f ~/.config/zsh/fzf_tab.zsh ] && source ~/.config/zsh/fzf_tab.zsh
[ -f ~/.config/zsh/zstyles.zsh ] && source ~/.config/zsh/zstyles.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ] && source ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Node Version Manager
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# colorscript -r
# neofetch
# neofetch --ascii ~/.config/neofetch/ascii/bat_ascii --ascii_colors 4
# pfetch
nitch
