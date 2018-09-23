## Interactive shell variables
# Delay of zsh key sequences (like Esc), in 10 ms units
KEYTIMEOUT=1

# (GNU) ls formatting options
export BLOCK_SIZE="'1"       # Thousands separator for sizes
export TIME_STYLE="long-iso" # ISO 8601 datetimes
export CLICOLOR=1            # Colorize output

# Enable correct colors for ls
if (( $+commands[dircolors] )); then
  eval "$(dircolors --sh)"
else
  if [[ -z "$LSCOLORS" ]]; then
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
  fi
  if [[ -z "$LS_COLORS" ]]; then
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
  fi
fi
