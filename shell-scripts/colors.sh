#!/bin/zsh
# Escape Sequences
# literal   \e, \E
# octal     \033
# hex       \x1b

# Graphics Codes
# ESC[0m                reset all modes (styles and colors)
# ESC[1m    ESC[22m     set bold mode.
# ESC[2m    ESC[22m     set dim/faint mode.
# ESC[3m    ESC[23m     set italic mode.
# ESC[4m    ESC[24m     set underline mode.
# ESC[5m    ESC[25m     set blinking mode
# ESC[7m    ESC[27m     set inverse/reverse mode
# ESC[8m    ESC[28m     set hidden/invisible mode
# ESC[9m    ESC[29m     set strikethrough mode.

# Color Codes
# Color             Foreground      Background
# Black                 30              40
# Red                   31              41
# Green                 32              42
# Yellow                33              43
# Blue                  34              44
# Magenta               35              45
# Cyan                  36              46
# White                 37              47
# Default               39              49
# Bright Black          90              100
# Bright Red            91              101
# Bright Green          92              102
# Bright Yellow         93              103
# Bright Blue           94              104
# Bright Magenta        95              105
# Bright Cyan           96              106
# Bright White          97              107
# Reset                 0               0


# 256 Colors
# ESC[38;5;${color}m   set foreground color
# ESC[48;5;${color}m   set background color


COLORS=(
    "Black" "Red" "Green" "Yellow" "Blue" "Magenta" "Cyan" "White"
)

ESC="\033["
RESET="\033[0m"
TEXT=" abc "


printf "%-11s" " "
for i in {1..${#COLORS[@]}}; do
    printf "${ESC}$(( i + 29 ))m%-18s${RESET}" "${COLORS[i]}"
done
printf "\n\n"

for b in {40..47}; do
    printf "${ESC}$(( b - 10 ))m%-11s${RESET}" "${COLORS[$(( b - 39 ))]}    "
    for f in {30..37}; do
        printf "${ESC}${b};${f}m${TEXT}${RESET}    "
        printf "${ESC}${b};$(( f + 60 ));1m${TEXT}${RESET}    "
    done
    printf "\n\n"
    printf "%-11s" "${COLORS[$(( b - 39 + 8 ))]}    "
    for f in {90..97}; do
        printf "${ESC}${b};${f}m${TEXT}${RESET}    "
        printf "${ESC}${b};$(( f + 60 ));1m${TEXT}${RESET}    "
    done
    printf "\n\n"
done
