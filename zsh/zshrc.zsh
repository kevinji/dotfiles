#!/usr/bin/env zsh
# Profile loading time.
# zmodload zsh/zprof

# Follow symlinks to this script's directory.
if (( $+commands[greadlink] )); then
  alias readlink="greadlink"
fi

DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

source "$DIR/core.zsh"
source "$DIR/environment.zsh"
source "$DIR/aliases.zsh"
source "$DIR/functions.zsh"
source "$DIR/external-zshrc.zsh"

if [[ -f "$DIR/zshrc-local.zsh" ]]; then
  source "$DIR/zshrc-local.zsh"
fi

unset DIR

# Display profiled loading time.
# zprof
