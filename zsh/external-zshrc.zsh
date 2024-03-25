#!/usr/bin/env zsh
# gpg
if (( $+commands[gpg] )); then
  export GPG_TTY="$(tty)"
fi

# PostgreSQL
if [[ -f "$HOMEBREW_PREFIX/opt/postgresql/bin/postgres" ]]; then
  alias pg="$HOMEBREW_PREFIX/opt/postgresql/bin/postgres -D $HOMEBREW_PREFIX/var/postgres"
fi

# fzf
if [[ -d "$HOMEBREW_PREFIX/opt/fzf" ]]; then
  # Auto-completion
  [[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

# Google Cloud SDK
if [[ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

  gcurl() {
    curl --header "Authorization: Bearer $(gcloud auth print-identity-token)" "$@"
  }
fi
