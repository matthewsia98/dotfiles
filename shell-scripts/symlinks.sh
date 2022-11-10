#!/bin/zsh
if [[ ! -d "$HOME/.config/conky" ]] then
    ln -s ~/.dotfiles/conky/ ~/.config/conky
fi

if [[ ! -d "$HOME/.config/dunst" ]] then
    ln -s ~/.dotfiles/dunst/ ~/.config/dunst
fi

if [[ ! -d "$HOME/.config/feh" ]] then
    ln -s ~/.dotfiles/feh/ ~/.config/feh
fi

if [[ ! -d "$HOME/.config/gtk-3.0" ]] then
    ln -s ~/.dotfiles/gtk-3.0/ ~/.config/gtk-3.0
fi

if [[ ! -d "$HOME/.config/kitty" ]] then
    ln -s ~/.dotfiles/kitty/ ~/.config/kitty
fi

if [[ ! -d "$HOME/.config/neofetch" ]] then
    ln -s ~/.dotfiles/neofetch/ ~/.config/neofetch
fi

if [[ ! -d "$HOME/.config/nvim" ]] then
    ln -s ~/.dotfiles/nvim/ ~/.config/nvim
fi

if [[ ! -d "$HOME/.config/pcmanfm" ]] then
    ln -s ~/.dotfiles/pcmanfm/ ~/.config/pcmanfm
fi

if [[ ! -d "$HOME/.config/picom" ]] then
    ln -s ~/.dotfiles/picom/ ~/.config/picom
fi

if [[ ! -d "$HOME/.config/qtile" ]] then
    ln -s ~/.dotfiles/qtile/ ~/.config/qtile
fi

if [[ ! -d "$HOME/.config/rofi" ]] then
    ln -s ~/.dotfiles/rofi/ ~/.config/rofi
fi

if [[ ! -a "$HOME/.config/starship.toml" ]] then
    ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
fi

if [[ ! -d "$HOME/.config/sxhkd" ]] then
    ln -s ~/.dotfiles/sxhkd/ ~/.config/sxhkd
fi

if [[ ! -a "$HOME/.Xmodmap" ]] then
    ln -s ~/.dotfiles/X/.Xmodmap ~/.Xmodmap
fi

if [[ ! -a "$HOME/.Xresources" ]] then
    ln -s ~/.dotfiles/X/.Xresources ~/.Xresources
fi

if [[ ! -a "$HOME/.xsession" ]] then
    ln -s ~/.dotfiles/X/.xsession ~/.xsession
fi

if [[ ! -a "$HOME/.zshrc" ]] then
    ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
fi

if [[ ! -a "$HOME/.flake8" ]] then
    ln -s ~/.dotfiles/.flake8 ~/.flake8
fi

if [[ ! -a "$HOME/.luacheckrc" ]] then
    ln -s ~/.dotfiles/.luacheckrc ~/.luacheckrc
fi

if [[ ! -a "$HOME/.luarc.json" ]] then
    ln -s ~/.dotfiles/.luarc.json ~/.luarc.json
fi

if [[ ! -a "$HOME/.mypy.ini" ]] then
    ln -s ~/.dotfiles/.mypy.ini ~/.mypy.ini
fi

if [[ ! -a "$HOME/.stylua.toml" ]] then
    ln -s ~/.dotfiles/.stylua.toml ~/.stylua.toml
fi
