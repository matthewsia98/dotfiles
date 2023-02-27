fzf_tab_preview="${fzf_preview}"
fzf_tab_preview=$(sed 's/{}/${realpath}/g' <<< "${fzf_tab_preview}")

[ -f ~/repos/fzf-tab/fzf-tab.plugin.zsh ] && source ~/repos/fzf-tab/fzf-tab.plugin.zsh
