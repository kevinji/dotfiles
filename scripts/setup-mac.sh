#!/usr/bin/env zsh
set -euo pipefail

# Xcode CLT
xcode-select --install || true

# Homebrew
echo "Installing Homebrew..."

if [[ ! -x "$(command -v brew)" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Done installing Homebrew."
echo
