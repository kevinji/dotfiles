#!/bin/bash
# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE")"
dotfiles="$(cd "$scripts"/.. && pwd)"

echo "Symlinking files..."

# Symlink every dotfile into ~.
folders=(homebrew git tmux vim)

for folder in "${folders[@]}"; do
    for file in "$dotfiles"/"$folder"/*; do
        ln -s "$file" "$HOME"/."$(basename "$file")"
    done
done

# Symlink Prezto into ~/.zprezto.
ln -s "$dotfiles"/zsh/prezto "$HOME"/.zprezto

# Symlink the various zsh config files into ~.
for file in "$dotfiles"/zsh/*; do
    if [[ -f "$file" ]]; then
        ln -s "$file" "$HOME"/."$(basename "$file")"
    fi
done

echo "Done symlinking files."
echo
