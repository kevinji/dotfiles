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
