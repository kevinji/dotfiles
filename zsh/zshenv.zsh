#!/usr/bin/env zsh
ZDOTDIR="$HOME/.config/zsh"

# Aliases are here so they work in Vim
# Use macOS shortcuts everywhere
if [[ "${OSTYPE-}" == darwin* ]]; then
  alias o="open"
elif [[ "${OSTYPE-}" == cygwin* ]]; then
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

# Use :A instead of readlink because zshenv runs before zprofile, which adds
# Homebrew's greadlink to PATH.
DIR="${${(%):-%x}:A:h}"

if [[ -f "$DIR/zshenv-local.zsh" ]]; then
  source "$DIR/zshenv-local.zsh"
fi

unset DIR
