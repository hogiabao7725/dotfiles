#
# 30_functions.zsh
# Defines custom shell functions and utilities.
#

# --- Lazy Loading for Performance ---

# Lazy-load NVM (Node Version Manager) for faster shell startup.
nvm() {
  unfunction nvm # Remove this temporary function.
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Load the real nvm.
  nvm "$@" # Call the real nvm with all arguments.
}

# --- Custom Utility Functions ---

# Creates a new directory and changes into it.
# Usage: mkcd my_new_directory
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Universal file extractor
# Usage: extract <file>
# Handles .zip, .tar, .tar.gz, .tar.bz2, etc.
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# --- Smart Dynamic Tab Title for WezTerm & Zsh ---

# Core function to set the terminal title.
# Uses `print -Pn` which is a fast, built-in Zsh command.
set_terminal_title() {
  print -Pn "\e]0;$1\a"
}

# Displays the current directory in the title when the shell is idle.
# Called by the `precmd` hook (before the prompt is drawn).
# `%1~` shows only the trailing directory name for brevity.
# Note: Use `%~` for the full path from the home directory.
set_title_to_directory() {
  set_terminal_title "%1~"
}

# Displays the running command in the title just before execution.
# Called by the `preexec` hook.
set_title_to_command() {
  # Split the command string from the hook's first argument ($1) into an array.
  # The Zsh-native '(z)' flag correctly handles quotes and is very fast.
  local -a words=("${(z)1}")
  (( ${#words[@]} )) || return # Exit if the command is empty.

  # Strip leading environment variable assignments (e.g., "LANG=C git status").
  while [[ ${words[1]} == [A-Za-z_]*=* ]]; do
    shift words
    (( ${#words[@]} )) || return # Exit if only variables were present.
  done

  # Get the base name of the command, stripping the path (e.g., /bin/ls -> ls).
  # The `:t` modifier (tail) is a powerful Zsh parameter expansion feature.
  local cmd=${words[1]:t}

  # For specific commands, include the subcommand for more context.
  case $cmd in
    sudo|ssh|git|docker|npm|yarn)
      # Show "git status" or "sudo vim" instead of just "git" or "sudo".
      # Also apply `:t` to the subcommand for consistency.
      set_terminal_title "$cmd ${words[2]:t}"
      ;;
    *)
      # Default to showing just the command name.
      set_terminal_title "$cmd"
      ;;
  esac
}

# Autoload the `add-zsh-hook` function to ensure it's available.
# This is a robust way to make the script work even in minimal Zsh setups.
autoload -Uz add-zsh-hook

# Register the functions with Zsh's hooks.
# This method is safe and won't override existing hooks from other plugins.
add-zsh-hook precmd  set_title_to_directory
add-zsh-hook preexec set_title_to_command
add-zsh-hook chpwd   set_title_to_directory # Updates title immediately on `cd`.

# Set the initial title when the shell starts up.
set_title_to_directory
