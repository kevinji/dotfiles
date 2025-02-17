#!/usr/bin/env zsh
# direnv
if (( $+commands[direnv])); then
  eval "$(direnv hook zsh)"
fi

# gpg
if (( $+commands[gpg] )); then
  export GPG_TTY="$(tty)"
fi

# fzf
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# Google Cloud SDK
if (( $+commands[gcloud] )); then
  gcurl() {
    curl --header "Authorization: Bearer $(gcloud auth print-identity-token)" "$@"
  }
fi

# Tailscale
if [[ -f "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ]]; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi
