#!/usr/bin/env zsh
# fd
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Opam
if (( $+commands[opam] )); then
  eval "$(opam env)"
fi

# Local ~/.local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  path+=("$HOME/.local/bin")
fi

# Rustup
if (( $+commands[rustup] )); then
  # Auto-installation by rustup can cause corruption of toolchains or components:
  # https://github.com/rust-lang/rustup/issues/988
  export RUSTUP_AUTO_INSTALL=0
fi

# Cargo
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# Go
if [[ -d "$HOME/go/bin" ]]; then
  path+=("$HOME/go/bin")
fi

# Doom Emacs
if [[ -d "$HOME/.config/emacs/bin" ]]; then
  path+=("$HOME/.config/emacs/bin")
fi

# Foundry
if [[ -d "$HOME/.foundry/bin" ]]; then
  path+=("$HOME/.foundry/bin")
fi

# OrbStack
if [[ -f "$HOME/.orbstack/shell/init.zsh" ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi
