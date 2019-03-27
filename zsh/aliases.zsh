#!/usr/bin/env zsh
## General
alias type="type -a"

if (( $+commands[perl] )); then
  alias psed="perl -p0e" # Shadows `psed` provided by perl.
fi

if (( $+commands[ncdu] )); then
  alias ncdu="ncdu --color dark" # Enable colors.
fi

## Directories
alias l="ls -1A"   # Lists in one column, hidden files.
alias ll="ls -lh"  # Lists human readable sizes.
alias la="ls -Alh" # Lists human readable sizes, hidden files.

if (( $+commands[exa] )); then
  alias xs="exa"
  alias x="exa -1a"   # Lists in one column, hidden files.
  alias xl="exa -lh"  # Lists human readable sizes.
  alias xa="exa -alh" # Lists human readable sizes, hidden files.
fi

alias mkdir="${aliases[mkdir]:-mkdir} -p" # Make intermediate directories.

## Git
if (( $+commands[git] )); then
  alias g="git"

  alias ga="git add"
  alias gA="git add --patch"

  alias gb="git branch"
  alias gba="git branch --all --verbose"
  alias gbd="git branch --delete"
  alias gbD="git branch --delete --force"
  alias gbl="git branch --verbose"

  alias gc="git commit --verbose"
  alias gcm="git commit --message"
  alias gcf="git commit --amend --reuse-message HEAD"
  alias gcF="git commit --verbose --amend"

  alias gco="git checkout"

  alias gf="git fetch"
  alias gfc="git clone"
  alias gfu="git fetch upstream"
  alias gfm="git pull"
  alias gfmu="git pull upstream master"

  alias gid="git diff --no-ext-diff --cached"
  alias giD="git diff --no-ext-diff --cached --word-diff"
  alias gir="git reset"

  _git_log_medium_format="%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B"
  _git_log_oneline_format="%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n"
  _git_log_brief_format="%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n"

  alias gl="git log --topo-order --pretty=format:'${_git_log_medium_format}'"
  alias gls="git log --topo-order --stat --pretty=format:'${_git_log_medium_format}'"
  alias glo="git log --topo-order --pretty=format:'${_git_log_oneline_format}'"
  alias glg="git log --topo-order --all --graph --pretty=format:'${_git_log_oneline_format}'"
  alias glb="git log --topo-order --pretty=format:'${_git_log_brief_format}'"

  alias gm="git merge"

  alias gp="git push"
  alias gpf="git push --force-with-lease"
  alias gpF="git push --force"

  alias gr="git rebase"

  alias gR="git remote"
  alias gRl="git remote --verbose"

  alias gs="git stash"
  alias gsa="git stash apply"
  alias gsl="git stash list"
  alias gsp="git stash pop"

  alias gws="git status --ignore-submodules=all --short"
  alias gwS="git status --ignore-submodules=all"
  alias gwd="git diff --no-ext-diff"
  alias gwD="git diff --no-ext-diff --word-diff"
  alias gwr="git reset --soft"
  alias gwR="git reset --hard"
fi
