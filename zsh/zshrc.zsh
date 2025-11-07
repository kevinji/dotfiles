#!/usr/bin/env zsh
# Profile loading time.
# zmodload zsh/zprof

# Follow symlinks to this script's directory.
if (( $+commands[greadlink] )); then
  alias readlink="greadlink"
fi

DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ "${TERM-}" != "dumb" && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$DIR/core.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
if [[ "${TERM-}" != "dumb" && -f "$DIR/p10k.zsh" ]]; then
  source "$DIR/p10k.zsh"
fi

if [[ -f "$DIR/zshrc-early-local.zsh" ]]; then
  source "$DIR/zshrc-early-local.zsh"
fi

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
