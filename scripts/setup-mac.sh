#!/bin/bash
# Grab the current directory.
base="$(dirname "$BASH_SOURCE")"

# Xcode
xcode-select --install

# Homebrew
echo "Installing Homebrew..."

if ! type brew &> /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update &> /dev/null

brew linkapps &> /dev/null

# Run general scripts.
"$base"/setup.sh
