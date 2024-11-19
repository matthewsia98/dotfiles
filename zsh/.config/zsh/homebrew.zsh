export HOMEBREW_PREFIX="$(/opt/homebrew/bin/brew --prefix)"

export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"

# unversioned symlinks python -> python3, pip -> pip3, etc.
export PATH="$(brew --prefix python)/libexec/bin:${PATH}"

export PATH="${HOMEBREW_PREFIX}/opt/postgresql@15/bin:${PATH}"

# export CC="${HOMEBREW_PREFIX}/bin/gcc-14"

FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
FPATH="${HOMEBREW_PREFIX}/share/zsh/zsh-completions:${FPATH}"

alias brewin="brew install"
alias brewrm="brew uninstall"
alias brewg="brew list --versions | grep"

alias checkupdates="brew update && brew outdated"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
