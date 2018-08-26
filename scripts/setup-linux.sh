#!/bin/bash
set -e

# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE[0]")"
dotfiles="$(cd "$scripts/.." && pwd)"

# Run general scripts.
"$dotfiles/scripts/setup.sh"
