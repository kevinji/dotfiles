#!/usr/bin/env zsh
sum() {
  awk '{ sum += $1 } END { print sum }'
}

update_python() {
  if (( $+commands[pip2] )); then
    pip2 install -q --upgrade pip
    pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip2 install -q -U
  fi

  if (( $+commands[pip3] )); then
    pip3 install -q --upgrade pip
    pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -q -U
  fi
}

reset_pip() {
  if (( $+commands[pip2] )); then
    pip2 uninstall -y -r <(pip2 freeze)
  fi

  if (( $+commands[pip3] )); then
    pip3 uninstall -y -r <(pip3 freeze)
  fi
}

update_vim() {
  vim +PlugUpdate +qall
}

update_ycm() {
  pushd "$HOME/.vim/plugged/youcompleteme"
  python3 ./install.py --clang-completer --js-completer --rust-completer --java-completer
  popd
}

reload_tmux() {
  tmux source-file "$HOME/.tmux.conf"
}
