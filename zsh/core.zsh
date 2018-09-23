# zsh options
setopt COMBINING_CHARS      # Display accented chars as one char.
setopt INTERACTIVE_COMMENTS # Allow comments in shell.
setopt RC_QUOTES            # Allow 'A''s' to mean 'A'\''s'.
setopt NO_BEEP              # Disable beeps.

setopt LONG_LIST_JOBS       # List jobs in the long format.
setopt NOTIFY               # Notify about background jobs immediately.
setopt NO_BG_NICE           # Do not run background jobs at a lower priority.
setopt NO_HUP               # Keep jobs alive on shell exit.
setopt NO_CHECK_JOBS        # Disable warning that checks for running jobs.

setopt AUTO_PUSHD           # Make `cd` work like `pushd`.
setopt PUSHD_SILENT         # Avoid printing the stack after `pushd`/`popd`.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Make globs more powerful.
setopt NO_CASE_GLOB         # Make globs case-insensitive.

setopt COMPLETE_IN_WORD     # Complete from both sides of a word.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH     # Add a slash automatically after a directory name.
setopt NO_FLOW_CONTROL      # Disable start/stop characters.

# zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY     # Use the ":start:elapsed;command" format for history entries.
setopt INC_APPEND_HISTORY   # Append to history file during shell session.
setopt SHARE_HISTORY        # Share history between sessions.
setopt HIST_IGNORE_ALL_DUPS # Delete older duplicated events from history.
setopt HIST_FIND_NO_DUPS    # Avoid displaying duplicate history entries.
setopt HIST_SAVE_NO_DUPS    # Avoid saving duplicate history entries.
setopt HIST_VERIFY          # Do not execute history expanded lines.

# Case-insensitive, pattern-word, and substring completion.
zstyle ":completion:*" matcher-list "m:{[:lower:][:upper:]}={[:upper:][:lower:]}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"

# Cache completion
zstyle ":completion::complete:*" use-cache on

# zsh functions
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Source antibody plugins
[[ -f "$HOME/.zsh_plugins.sh" ]] && source "$HOME/.zsh_plugins.sh"

# zsh features
autoload -Uz compinit
compinit

# bash emulation
autoload -Uz bashcompinit
bashcompinit

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Enable proper backspacing in vi mode
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

# zsh-history-substring-search
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Search backwards and forwards
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
