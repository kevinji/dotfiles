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

# Local ~/.local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  path+=("$HOME/.local/bin")
fi

# Cargo
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# Doom Emacs
if [[ -d "$HOME/.emacs.d/bin" ]]; then
  path+=("$HOME/.emacs.d/bin")
fi
