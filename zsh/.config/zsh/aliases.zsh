# Shell
alias ..="cd ..;"
alias hg="history 1 | grep"
alias grep="grep --color=auto"
alias ls="lsd -l"
alias ll="lsd -alh"
alias lll="lsd -alhL"
alias dirs="dirs -v"
alias cp="cp -rv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias cat="bat"
alias rg="rg -S"
alias tree="tree -CF"
alias hexdump="hexdump -C"
alias logout='loginctl terminate-user $USER'
alias suspend="systemctl suspend"

# Programs
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias gitui="gitui --theme mocha.ron"
alias pdf="zathura"
alias asciiquarium="asciiquarium --transparent"
alias uotp="python ~/Misc/uottawa_otp.py"
if [ "$XDG_SESSION_TYPE" = "wayland" ]
then
    alias img="swayimg"
elif [ "$XDG_SESSION_TYPE" = "x11" ]
then
    alias img="feh --scroll-step 20 --zoom-step 5 --scale-down -d -g 1900x980 --info "echo %wx%h" --image-bg #494D54"
fi
alias syncthing-web="xdg-open http://localhost:8384"

# Git
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
alias grm="git rm -r --cached"
alias gRM="git rm -r"
alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias gsh="git stash"
alias gsp="git stash pop"
alias gf="git fetch --verbose"
alias gm="git merge --verbose"

# Pacman
alias pac="sudo pacman"
alias pacin="sudo pacman -S"
alias pacrm="sudo pacman -Rsu"
alias pacsyu="sudo pacman -Syu"
alias pacg="pacman -Q | grep"
alias pacls="pacman -Q"

# Miscellaneous
alias dots="cd ~/.dotfiles"
alias schedule="img ~/Pictures/schedule.png"
alias term="cd ~/uOttawa/2023-Winter/"