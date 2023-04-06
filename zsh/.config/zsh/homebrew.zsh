export HOMEBREW_PREFIX="$(brew --prefix)"

export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/postgresql@15/bin:${PATH}"

export CC="${HOMEBREW_PREFIX}/bin/gcc-12"

FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
FPATH="${HOMEBREW_PREFIX}/share/zsh/zsh-completions:${FPATH}"
