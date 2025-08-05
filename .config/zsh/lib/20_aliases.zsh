#
# 20_aliases.zsh
# Defines command aliases.
#

# --- File & Directory Operations ---
# If eza is installed, use it for directory listings.
if type eza &>/dev/null; then
  alias ls='eza --icons' # List files with icons
  alias ll='eza --icons -laF --git' # List all files, long format, with git status
  alias la='eza --icons -aF' # List all files including hidden
  alias l='eza --icons -CF'  # List files in columns
else
  # Fallback to standard ls if eza is not found
  alias ls='ls --color=auto'
  alias ll='ls -alF' # List all files in long format
  alias la='ls -A'   # List all files including hidden
  alias l='ls -CF'   # List files in columns
fi

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Safety Features ---
# Prompt before overwriting files.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# --- Utility Aliases ---
alias grep='grep --color=auto'
alias df='df -h'     # Disk-free in human-readable format
alias du='du -h'     # Disk-usage in human-readable format
alias mkdir='mkdir -p' # Create parent directories as needed

# --- System Package Manager (uncomment for your OS) ---
# For Debian/Ubuntu
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias remove='sudo apt remove'

# For Arch Linux
# alias update='sudo pacman -Syu'
# alias install='sudo pacman -S'
# alias remove='sudo pacman -Rns'

# For macOS (Homebrew)
# alias update='brew update && brew upgrade'
# alias install='brew install'
# alias remove='brew uninstall'

#
# --- Zsh Performance ---
# Compiles all .zsh config files into .zwc for faster loading.
# Run this command every time you edit a .zsh file.
# alias zshcompile='for f in ~/.config/zsh/{.zshrc,lib/*.zsh}; do zcompile "$f"; echo "Compiled: $f"; done' !!!Error
# alias zshcompile="zcompile ~/.zshrc && zcompile ~/.config/zsh/lib/*.zsh"
# ==> convert to 99_zsh_compile.zsh


# --- Dotfiles Management ---
# Alias to quickly navigate to and edit dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
