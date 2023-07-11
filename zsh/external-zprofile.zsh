#!/usr/bin/env zsh
# fd
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# asdf
if (( $+commands[asdf] && $+commands[brew] )); then
  source "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
  fpath+=("$ASDF_DIR/completions")
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
if [[ -d "$HOME/.config/emacs/bin" ]]; then
  path+=("$HOME/.config/emacs/bin")
fi

# Google Cloud
if [[ -d "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin" ]]; then
  path+=("/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin")
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
if [[ -d "$HOME/.orbstack/bin" ]]; then
  path+=("$HOME/.orbstack/bin")
fi
