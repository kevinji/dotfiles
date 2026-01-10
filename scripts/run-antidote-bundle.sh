#!/usr/bin/env zsh
set -euo pipefail

if [[ -v HOMEBREW_PREFIX && -d "$HOMEBREW_PREFIX/opt/antidote/share/antidote" ]]; then
  antidote_dir="$HOMEBREW_PREFIX/opt/antidote/share/antidote"
elif [[ -d "${ZDOTDIR:-$HOME/.config/zsh}/.antidote" ]]; then
  antidote_dir="${ZDOTDIR:-$HOME/.config/zsh}/.antidote"
elif (( $+commands[nix] )); then
  antidote_dir="$(nix path-info 'nixpkgs#antidote')/share/antidote"
elif (( ! $+commands[antidote] )); then
  echo "antidote not found!"
  exit 1
fi

fpath=($antidote_dir/functions $fpath)
autoload -Uz antidote

antidote bundle < ~/.config/zsh/.zsh_plugins.txt >| ~/.config/zsh/.zsh_plugins.zsh
