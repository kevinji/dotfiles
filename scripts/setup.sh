#!/bin/bash
set -e

# Navigate to the dotfiles/ dir.
scripts="$(dirname "$BASH_SOURCE[0]")"
dotfiles="$(cd "$scripts/.." && pwd)"

bash -e ../install

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
