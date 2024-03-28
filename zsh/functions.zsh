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

if [[ "$OSTYPE" == darwin* ]]; then
  cross_linux() {
    cross "$@" --target aarch64-unknown-linux-gnu
  }
fi
