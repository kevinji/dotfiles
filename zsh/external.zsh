# gpg
if (( $+commands[gpg] )); then
  export GPG_TTY="$(tty)"
fi

# fzf
if [[ -d "/usr/local/opt/fzf" ]]; then
  path+=("/usr/local/opt/fzf/bin")
fi

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Load rbenv automatically
if (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
fi

# Opam
if [[ "$no_opam" != "true" ]]; then
  if (( $+commands[opam] )); then
    eval "$(opam env)"
  fi
fi

if [[ "$no_sudo" = "true" ]]; then
  # npm
  if (( $+commands[npm] )); then
    export NPM_CONFIG_PREFIX="$HOME/.npm-global"
    path+=("$NPM_CONFIG_PREFIX/bin")
  fi
fi

# Set `RUST_SRC_PATH` for Racer.
if (( $+commands[rustc] )); then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Set up after `rustup-init`:
# 1. Create `~/.zfunc`.
# 2. Run `rustup completions zsh > ~/.zfunc/_rustup`.
if [[ -d "$HOME/.cargo" ]]; then
  path+=("$HOME/.cargo/bin")
  fpath+=("$HOME/.zfunc")
fi
