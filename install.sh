#!/bin/sh

if [[ "$1" == "nvim" ]]
then
    stow nvim

    if [[ "$TERM" == *"kitty"* ]]
    then
        kitty_themes_dir="$HOME/.config/kitty/themes/"
        if [[ ! -d "$kitty_themes_dir" ]]
        then
            mkdir -v "$kitty_themes_dir"
        fi

        # Catppuccin
        curl "https://raw.githubusercontent.com/catppuccin/kitty/main/frappe.conf" -o "${kitty_themes_dir}frappe.conf"
        curl "https://raw.githubusercontent.com/catppuccin/kitty/main/latte.conf" -o "${kitty_themes_dir}latte.conf"
        curl "https://raw.githubusercontent.com/catppuccin/kitty/main/macchiato.conf" -o "${kitty_themes_dir}macchiato.conf"
        curl "https://raw.githubusercontent.com/catppuccin/kitty/main/mocha.conf" -o "${kitty_themes_dir}mocha.conf"

        # Tokyonight
        curl "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_day.conf" -o "${kitty_themes_dir}tokyonight_day.conf"
        curl "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_moon.conf" -o "${kitty_themes_dir}tokyonight_moon.conf"
        curl "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_night.conf" -o "${kitty_themes_dir}tokyonight_night.conf"
        curl "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_storm.conf" -o "${kitty_themes_dir}tokyonight_storm.conf"
    fi
fi
