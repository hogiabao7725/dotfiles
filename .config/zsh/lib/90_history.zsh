#
# 90_history.zsh
# Configures Zsh's command history behavior.
#

# --- History File Location and Size ---
# Set where to store the history file and how many lines to keep.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

# --- History Behavior Options ---
setopt APPEND_HISTORY         # Append to the history file, don't overwrite it.
setopt SHARE_HISTORY          # Share history between all active shell sessions in real-time.
setopt EXTENDED_HISTORY       # Store timestamp and duration for each command.
setopt HIST_IGNORE_ALL_DUPS   # If you run the same command multiple times in a row, only save it once.
setopt HIST_SAVE_NO_DUPS      # Don't save duplicate commands that are already in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from commands before saving.
setopt INC_APPEND_HISTORY     # Save each command to the history file as soon as it's executed.
