#!/usr/bin/zsh
for file in $(ls $HOME/.config/conky)
do
    conky -c $HOME/.config/conky/$file &
done
