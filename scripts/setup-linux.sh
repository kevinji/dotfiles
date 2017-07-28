#!/bin/bash
# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE")"
dotfiles="$(cd "$scripts"/.. && pwd)"

# Run general scripts.
"$dotfiles"/scripts/setup.sh

# Linuxbrew
echo "Installing Linuxbrew..."

if ! type brew &> /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi

brew tap homebrew/bundle
brew update &> /dev/null

# Install from Brewfile.
brew bundle --global

brew linkapps &> /dev/null
brew cleanup &> /dev/null

echo "Done installing Linuxbrew."
echo
