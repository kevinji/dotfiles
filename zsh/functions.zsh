#!/usr/bin/env zsh
sum() {
  awk '{ sum += $1 } END { print sum }'
}

update_vim() {
  vim +PlugUpdate +qall
}

reload_tmux() {
  tmux source-file "$HOME/.tmux.conf"
}

upload_ghostty_terminfo() {
  infocmp -x xterm-ghostty | ssh "$1" -- tic -x -
}

if [[ "${OSTYPE-}" == darwin* ]]; then
  cross_linux() {
    cross "$@" --target aarch64-unknown-linux-gnu
  }
fi
