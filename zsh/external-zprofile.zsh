#!/usr/bin/env zsh
# fd
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# mise
if (( $+commands[mise] )); then
  path=("$HOME/.local/share/mise/shims" $path)
  export MISE_NODE_COREPACK=true
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

# Go
if [[ -d "$HOME/go/bin" ]]; then
  path+=("$HOME/go/bin")
fi

# Doom Emacs
if [[ -d "$HOME/.config/emacs/bin" ]]; then
  path+=("$HOME/.config/emacs/bin")
fi

# Google Cloud
if [[ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin" ]]; then
  path+=("$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin")
fi

# Solana
if [[ -d "$HOME/.local/share/solana/install/active_release/bin" ]]; then
  path+=("$HOME/.local/share/solana/install/active_release/bin")
fi

# Foundry
if [[ -d "$HOME/.foundry/bin" ]]; then
  path+=("$HOME/.foundry/bin")
fi

# OrbStack
if [[ -f "$HOME/.orbstack/shell/init.zsh" ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi
