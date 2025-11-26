# ~/.config/fish/conf.d/01_env.fish

# Encoding
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Editor
set -gx EDITOR micro
set -gx VISUAL $EDITOR

# Pager
set -gx PAGER less
set -gx LESS '-R'

# Add user's local bin to PATH
# (fish avoids duplicates by default)
fish_add_path "$HOME/.local/bin"
