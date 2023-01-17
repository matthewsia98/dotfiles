#!/bin/sh

gnome_schema="org.gnome.desktop.interface"
cursor_theme=$(gsettings get "$gnome_schema" cursor-theme)
cursor_size=$(gsettings get "$gnome_schema" cursor-size)
cursor_theme=$(sed -e "s/^'//" -e "s/'$//" <<< "$cursor_theme")

hyprctl setcursor "$cursor_theme" "$cursor_size"
