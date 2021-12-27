#!/usr/bin/env zsh
# fd
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# asdf
if (( $+commands[asdf] )); then
  if (( $+commands[brew] )); then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
  fi
fi

# Opam
if (( $+commands[opam] )); then
  eval "$(opam env)"
fi
