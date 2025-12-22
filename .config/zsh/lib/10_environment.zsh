#
# 10_environment.zsh
# Sets environment variables.
#

# Set character encoding to UTF-8 for broad compatibility.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set default text editor (uncomment your preferred one).
export EDITOR='micro'
export VISUAL="$EDITOR"

# Use `less` as the default pager with options to support colors.
export PAGER='less'
export LESS='-R'

# Paths for version managers.
# The actual loading logic is handled in 30_functions.zsh.
export NVM_DIR="$HOME/.nvm"

# Add personal scripts directory to the PATH if it exists.
# This allows you to run your own scripts from anywhere.
if [[ -d "$HOME/.local/bin" && ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi
export PATH
