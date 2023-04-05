# lets files beginning with a . be matched without explicitly specifying the dot
# setopt GLOB_DOTS

setopt EXTENDED_GLOB

# make globbing case insensitive
# unsetopt CASE_GLOB
setopt NO_CASE_GLOB

# Add to history immediately, not on exit
setopt INC_APPEND_HISTORY

# Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
setopt EXTENDED_HISTORY

setopt HIST_IGNORE_ALL_DUPS

# cd if command is name of directory
setopt AUTO_CD
