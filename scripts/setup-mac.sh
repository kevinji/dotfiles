#!/bin/bash
set -e

# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE")"
dotfiles="$(cd "$scripts"/.. && pwd)"

# Run general scripts.
"$dotfiles"/scripts/setup.sh

# Xcode CLT
xcode-select --install || true

# Homebrew
echo "Installing Homebrew..."

if [[ ! -x "$(command -v brew)" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/bundle
brew update &> /dev/null

# Install from Brewfile.
brew bundle --global

brew linkapps &> /dev/null
brew cleanup &> /dev/null

echo "Done installing Homebrew."
echo
