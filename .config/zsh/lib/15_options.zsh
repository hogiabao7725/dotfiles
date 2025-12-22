# --- Enhanced Completion Styling ---
# These styles improve the behavior and appearance of the completion system.

# Make the completion menu selectable with arrow keys and Enter.
# THIS IS THE KEY to fixing the cursor position issue.
zstyle ':completion:*' menu select

# Enable color-coded listings for completions.
# It uses your system's LS_COLORS environment variable for a consistent look.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Show helpful descriptions for completion groups (e.g., 'aliases', 'functions').
zstyle ':completion:*' auto-description 'specify: %d'

# Make the completion system more verbose and informative.
zstyle ':completion:*' verbose yes


