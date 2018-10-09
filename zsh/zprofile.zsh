# Follow symlinks to this script's directory.
if (( $+commands[greadlink] )); then
  alias readlink="greadlink"
fi

DIR="$(dirname "$(readlink -f "${(%):-%x}")")"

source "$DIR/variables.zsh"

## Local changes
if [[ -f "$HOME/.zprofile-local" ]]; then
  source "$HOME/.zprofile-local"
fi

source "$DIR/external.zsh"
