## Basic variables
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="open"
fi

if (( $+commands[vimx] )); then
  alias vi="vimx"
  alias vim="vimx"
  alias vimdiff="vimx -d"
  export EDITOR="vimx"
elif (( $+commands[nvim] )); then
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

export VISUAL="$EDITOR"
export PAGER="less"

if [[ -z "$LANG" ]]; then
  export LANG="en_US.UTF-8"
fi

## Paths
# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

## Less
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS="-F -g -i -M -R -S -w -x4 -X -z-4"

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Disable the Less history file that stores search and shell commands.
export LESSHISTFILE=-

## Temporary files
# Set TMPDIR if the variable is not set/empty or the directory doesn't exist
if [[ -z "${TMPDIR}" ]]; then
  export TMPDIR="/tmp/zsh-${UID}"
fi

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi
