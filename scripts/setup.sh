#!/bin/bash
set -e

# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE")"
dotfiles="$(cd "$scripts"/.. && pwd)"

echo "Symlinking files..."

# Symlink every dotfile into ~.
dotfile_folders=(git homebrew spacemacs tmux vim)

for folder in "${dotfile_folders[@]}"; do
    for file in "$dotfiles"/"$folder"/*; do
        ln -sn "$file" "$HOME"/."$(basename "$file")" || true
    done
done

# Symlink every dot-FOLDER into ~/.FOLDER.
copy_folders=(pip shell)

for folder in "${copy_folders[@]}"; do
    ln -sn "$dotfiles"/"$folder" "$HOME"/."$folder" || true
done

# Symlink Prezto into ~/.zprezto.
ln -sn "$dotfiles"/zsh/prezto "$HOME"/.zprezto || true

# Symlink Prezto's zsh config files into ~.
for file in "$dotfiles"/zsh/prezto/runcoms/*; do
    if [[ "$(basename "$file")" != "README.md" ]]; then
        ln -sn "$file" "$HOME"/."$(basename "$file")" || true
    fi
done

# Symlink the overridden zsh config files into ~.
for file in "$dotfiles"/zsh/*; do
    if [[ -f "$file" ]]; then
        rm -f "$HOME"/."$(basename "$file")"
        ln -sn "$file" "$HOME"/."$(basename "$file")" || true
    fi
done

# Clone Tmux Plugin Manager into ~/.tmux/plugins.
git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm || true

# Install vim-plug into ~/.vim/autoload.
curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Done symlinking files."
echo
echo "Set zsh as your login shell: chsh -s \$(which zsh)"
echo "You may need to add zsh to /etc/shells."
echo
