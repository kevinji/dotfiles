#!/usr/bin/env zsh
# Use macOS shortcuts everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o="open"
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o="cygstart"
  alias pbcopy="tee > /dev/clipboard"
  alias pbpaste="cat /dev/clipboard"
else
  alias o="xdg-open"
  if (( $+commands[xclip] )); then
    alias pbcopy="xclip -selection clipboard -in"
    alias pbpaste="xclip -selection clipboard -out"
  elif (( $+commands[xsel] )); then
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
  fi
fi

alias pbc="pbcopy"
alias pbp="pbpaste"
