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

# Lazy-load SDKMAN for faster shell startup.
sdk() {
  unfunction sdk # Remove this temporary function.
  [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@" # Call the real sdk with all arguments.
}

# Lazyload goenv
goenv() {
  unfunction goenv 2>/dev/null
  [ -s "$GOENV_ROOT/bin/goenv" ] || { echo "goenv not found in $GOENV_ROOT/bin"; return 1; }
  eval "$("$GOENV_ROOT/bin/goenv" init -)"
  if [ $# -eq 0 ]; then
    return 0
  fi
  command goenv "$@"
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

# --- Dynamic Terminal Title ---
# This function is automatically called by Zsh every time the directory changes.
# It updates the terminal title to show the current working directory.
chpwd() {
  # %1~: Shows '~' for the home directory, or just the current directory's name otherwise.
  # \e]0;...\a: The standard terminal escape code to set the window and tab title.
  # print -Pn: Prints without a newline (-n) and processes prompt escapes like %1~ (-P).
  print -Pn "\e]0;%1~\a"
}

# Call chpwd once when Zsh starts to set the initial title correctly.
# Add this line at the VERY END of the file, after the function definition.
chpwd
