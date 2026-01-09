#!/usr/bin/env zsh
set -euo pipefail

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

pubkey=$(tailscale lock status --json | jq -r '.PublicKey')
tlpub="tlpub:${pubkey#nlpub:}"

mullvad_locked_nodes=$(tailscale lock status | grep -E 'mullvad.*nodekey')

echo "$mullvad_locked_nodes" | while IFS= read -r line; do
  echo "$line"

  if [[ "$line" =~ "nodekey:"[[:space:]]*(.*) ]]; then
    matched_string="nodekey:${match[1]}"

    tailscale lock sign "$matched_string" "$tlpub"
  fi
done
