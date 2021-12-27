#!/usr/bin/env zsh
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
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
