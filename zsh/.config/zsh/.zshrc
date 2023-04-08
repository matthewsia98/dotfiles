if [ "$(uname)" = "Linux" ]
then
    open_command="xdg-open"
elif [ "$(uname)" = "Darwin" ]
    open_command="mac-os-open"
then
fi

if type brew &> /dev/null
then
    [ -f "${ZDOTDIR}/homebrew.zsh" ] && source "${ZDOTDIR}/homebrew.zsh"
fi

[ -f "${ZDOTDIR}/environment.zsh" ] && source "${ZDOTDIR}/environment.zsh"
[ -f "${ZDOTDIR}/utils.zsh" ] && source "${ZDOTDIR}/utils.zsh"
[ -f "${ZDOTDIR}/aliases.zsh" ] && source "${ZDOTDIR}/aliases.zsh"
[ -f "${ZDOTDIR}/options.zsh" ] && source "${ZDOTDIR}/options.zsh"
[ -f "${ZDOTDIR}/keybinds.zsh" ] && source "${ZDOTDIR}/keybinds.zsh"

# Disable % if line doesn"t end with \n
PROMPT_EOL_MARK=""

# Starship
eval "$(starship init zsh)"

# zsh-autosuggestions configuration
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#494D64,fg=#CAD3F5,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':completion:*' cache-path ~/.cache/zsh/.zcompcache
zmodload zsh/complist
autoload -Uz compinit && compinit -d ~/.cache/zsh/.zcompdump

[ -f "${ZDOTDIR}/fzf.zsh" ] && source "${ZDOTDIR}/fzf.zsh"
[ -f "${ZDOTDIR}/fzf_tab.zsh" ] && source "${ZDOTDIR}/fzf_tab.zsh"

[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ] && source ~/repos/zsh-syntax-highlighting-catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

[ -f "${HOMEBREW_PREFIX}/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "${HOMEBREW_PREFIX}/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "${HOMEBREW_PREFIX}/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "${HOMEBREW_PREFIX}/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# Node Version Manager
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
[ -f "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && source "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"

# System Fetch
# colorscript -r
neofetch
# pfetch
# nitch
