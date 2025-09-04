#
# 10_environment.zsh
# Sets environment variables.
#

# Set character encoding to UTF-8 for broad compatibility.
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set default text editor (uncomment your preferred one).
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Use `less` as the default pager with options to support colors.
export PAGER='less'
export LESS='-R'

# Paths for version managers.
# The actual loading logic is handled in 30_functions.zsh.
export NVM_DIR="$HOME/.nvm"

# Add personal scripts directory to the PATH if it exists.
# This allows you to run your own scripts from anywhere.
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
