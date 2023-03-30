fzf_tab_preview="${fzf_preview}"
fzf_tab_preview=$(sed 's/{}/${realpath}/g' <<< "${fzf_tab_preview}")

[ -f ~/repos/fzf-tab/fzf-tab.plugin.zsh ] && source ~/repos/fzf-tab/fzf-tab.plugin.zsh

zstyle ":fzf-tab:*" continuous-trigger "/"
zstyle ":fzf-tab:*" switch-group "ctrl-h" "ctrl-l"

zstyle ":completion:*:descriptions" format "[%d]"
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

zstyle ':fzf-tab:*' fzf-flags '--height=80%'
zstyle ':fzf-tab:complete:*' fzf-preview "${fzf_tab_preview}"
# Disable preview for command options
zstyle ':fzf-tab:complete:*:options' fzf-preview

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word --format=user,pid,command,start,etime'

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
zstyle ':fzf-tab:complete:git-branch:*' fzf-preview '\
    case "$group" in
    "recent commit object name") git show --color=always $word | delta ;;
    *) git log --color=always $word ;;
    esac'

zstyle ':fzf-tab:complete:brew-install:*' fzf-preview 'brew info $word'
