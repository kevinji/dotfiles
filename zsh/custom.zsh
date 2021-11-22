#!/usr/bin/env zsh
## Custom programs
# PostgreSQL
if (( $+commands[pg_ctl] )); then
  alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
fi

# fzf
if [[ -d "/usr/local/opt/fzf" ]]; then
  # Auto-completion
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

# Google Cloud SDK
if [[ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]]; then
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

  gcurl() {
    curl --header "Authorization: Bearer $(gcloud auth print-identity-token)" "$@"
  }
fi

# Objective-See apps
if [[ -d "/Applications/ProcessMonitor.app" ]]; then
  alias processmonitor="sudo /Applications/ProcessMonitor.app/Contents/MacOS/ProcessMonitor"
fi

if [[ -d "/Applications/FileMonitor.app" ]]; then
  alias filemonitor="sudo /Applications/FileMonitor.app/Contents/MacOS/FileMonitor"
fi
