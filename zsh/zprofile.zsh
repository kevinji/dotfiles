#!/usr/bin/env zsh
if [[ "${OSTYPE-}" == darwin* ]]; then
  if [[ $(arch) == "arm64" && -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ $(arch) == "i386" && -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Follow symlinks to this script's directory.
if (( $+commands[greadlink] )); then
  alias readlink="greadlink"
fi

DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

source "$DIR/variables.zsh"

if [[ -f "$DIR/zprofile-local.zsh" ]]; then
  source "$DIR/zprofile-local.zsh"
fi

source "$DIR/variables-after-overrides.zsh"
source "$DIR/external-zprofile.zsh"

unset DIR
