#!/bin/bash
set -e

# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE")"
dotfiles="$(cd "$scripts/.." && pwd)"

echo "Symlinking files..."

# Symlink every dotfile into ~.
dotfile_folders=(git homebrew spacemacs tmux vim zsh)

for folder in "${dotfile_folders[@]}"; do
    for file in "$dotfiles/$folder"/*; do
        ln -sn "$file" "$HOME/.$(basename "$file")" || true
    done
done

# Symlink every dot-FOLDER into ~/.FOLDER.
copy_folders=(pip ptpython)

for folder in "${copy_folders[@]}"; do
    ln -sn "$dotfiles/$folder" "$HOME/.$folder" || true
done

# Clone Tmux Plugin Manager into ~/.tmux/plugins.
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || true

# Install vim-plug into ~/.vim/autoload.
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Done symlinking files."
echo
echo "Set zsh as your login shell: chsh -s \"\$(which zsh)\""
echo "You may need to add zsh to /etc/shells."
echo
