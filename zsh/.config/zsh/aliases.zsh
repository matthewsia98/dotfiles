# Shell
alias clera="clear"
alias cl="clear"
alias ..="cd ..;"
alias hg="history 1 | grep"
alias grep="grep --color=auto"
alias ls="lsd -l"
alias ll="lsd -alh"
alias lll="lsd -alhL"
alias cp="cp -rv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias cat="bat"
alias rg="rg -S"
alias df="df -h"
alias tree="tree -CF"
alias hexdump="hexdump -C"
alias logout='loginctl terminate-user $USER'
alias suspend="systemctl suspend"

# Programs
# alias v="nvim"
# alias vi="nvim"
alias vim="nvim"
alias gitui="gitui --theme mocha.ron"
alias pdf="zathura"
alias asciiquarium="asciiquarium --transparent"
alias uotp="python ${HOME}/misc/uottawa_otp.py"
if [ "$(uname)" = "Darwin" ]
then
    alias img="open -a Preview"
elif [ "$(uname)" = "Linux" ]
then
    alias img="swayimg"
fi
alias feh="feh --scroll-step 20 --zoom-step 5 --scale-down -d -g 1900x980 --info 'echo %wx%h' --image-bg '#494D54'"
alias syncthing-web="${open_command} http://localhost:8384"

# Pip
if type pip &> /dev/null
then
    alias pipin="pip install"
    alias piprm="pip uninstall"
    alias pipg="pip list | grep"
fi

# Git
if type git &> /dev/null
then
    alias gcl="git clone --verbose"
    alias gs="git status"
    alias ga="git add --verbose"
    alias ga.="git add --verbose ."
    alias gc="git commit --message"
    alias gca="git commit --amend --message"
    alias gpl="git pull --verbose"
    alias gp="git push --verbose"
    alias gb="git branch --verbose --color=always"
    alias gco="git checkout"
    alias gd="git diff"
    alias gds="git diff --staged"
    alias gr="git rebase"
    # Removes the file only from the Git repository, but not from the filesystem
    alias grm="git rm -r --cached"
    # Deletes files both from the Git repository as well as the filesystem
    alias gRM="git rm -r"
    alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit"
    alias gsh="git stash"
    alias gsp="git stash pop"
    alias gf="git fetch --verbose"
    alias gm="git merge --verbose"
fi

# Pacman
if type pacman &> /dev/null
then
    alias pac="sudo pacman"
    alias pacin="sudo pacman -S"
    alias pacrm="sudo pacman -Rsu"
    alias pacsyu="sudo pacman -Syu"
    alias pacg="pacman -Q | grep"
    alias pacls="pacman -Q"
fi

# Miscellaneous
alias dots="cd ${HOME}/.dotfiles"
alias schedule="img ${HOME}/Pictures/schedule.png"
alias uottawa='${open_command} $(gum file ${HOME}/uOttawa/2023-Winter)'
alias twin="${open_command} https://this-week-in-neovim.org/latest"
