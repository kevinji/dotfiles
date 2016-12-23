#!/bin/bash
# Symlink every dotfile into ~.
folders=(git tmux vim)

for folder in "${folders[@]}"; do
    for file in "$HOME/dotfiles/$folder"/*; do
        ln -s "$file" "$HOME/.$(basename $file)"
    done
done
