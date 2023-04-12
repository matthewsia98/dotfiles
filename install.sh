#!/bin/sh

platform=$(uname)

install_fonts() {
	if [ "${platform}" = "Linux" ]; then
		fonts_dir="${HOME}/.fonts"
		if [ ! -d "${fonts_dir}" ]; then
			mkdir "${fonts_dir}"
		fi
		curl -LO --output-dir "${fonts_dir}" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
	elif [ "${platform}" = "Darwin" ]; then
		brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font
	fi
}

install_dotfiles() {
	git clone --depth 1 "https://github.com/matthewsia98/dotfiles.git"
}

install_programs() {
	if [ "${platform}" = "Linux" ]; then
		sudo pacman -S --needed --noconfirm \
			lsd \
			bat \
			stow \
			kitty \
			zathura-pdf-mupdf
	elif [ "${platform}" = "Darwin" ]; then
		brew tap zegervdv/zathura

		brew install \
			lsd \
			bat \
			stow \
			kitty \
			zathura-pdf-mupdf

		# REFERENCE: https://github.com/zegervdv/homebrew-zathura
		mkdir -p "$(brew --prefix zathura)/lib/zathura"
		ln -s "$(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib" "$(brew --prefix zathura)/lib/zathura/libpdf-mupdf.dylib"
	fi
}
