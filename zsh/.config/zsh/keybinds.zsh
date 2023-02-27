# Shell emacs/vim mode
bindkey -v

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line

bindkey "^h" ctrl-backspace

bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search

bindkey '^Xh' _complete_help

bindkey "^ " autosuggest-accept

bindkey -M vicmd "y" vi-yank-to-system-clip
bindkey -M vicmd "yy" vi-yank-line-to-system-clip
bindkey -M vicmd "Y" vi-yank-eol-to-system-clip
bindkey -M vicmd "dd" vi-delete-line-to-system-clip
bindkey -M vicmd "D" vi-delete-eol-to-system-clip
bindkey -M vicmd "p" vi-paste-from-system-clip
