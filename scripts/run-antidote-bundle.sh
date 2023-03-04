#!/usr/bin/env zsh

if [[ -f "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
elif [[ -f ~/.config/zsh/.antidote/antidote.zsh ]]; then
  source ~/.config/zsh/.antidote/antidote.zsh
fi

antidote bundle < ~/.config/zsh/.zsh_plugins.txt > ~/.config/zsh/.zsh_plugins.zsh
