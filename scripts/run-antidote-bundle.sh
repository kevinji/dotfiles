#!/usr/bin/env zsh

if [[ -f "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh" ]]; then
  source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
elif [[ -f ~/.config/zsh/.antidote/antidote.zsh ]]; then
  source ~/.config/zsh/.antidote/antidote.zsh
fi

antidote bundle < ~/.config/zsh/.zsh_plugins.txt > ~/.config/zsh/.zsh_plugins.zsh
