Either
1. export `ZDOTDIR` at the system level: `/etc/zsh/zshenv` or `/etc/zsh/zprofile`
2. place .zshenv in `$HOME` and export `ZDOTDIR` in there and zsh will continue in `ZDOTDIR`
  - `export ZDOTDIR="$HOME/.config/zsh`
