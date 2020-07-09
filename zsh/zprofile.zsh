#!/usr/bin/env zsh
# Follow symlinks to this script's directory.
if (( $+commands[greadlink] )); then
  alias readlink="greadlink"
fi

DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

source "$DIR/variables.zsh"

if [[ -f "$HOME/.zprofile-local" ]]; then
  source "$HOME/.zprofile-local"
fi

source "$DIR/variables-after-overrides.zsh"
source "$DIR/external.zsh"

unset DIR
