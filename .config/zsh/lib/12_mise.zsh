#
# 11_mise.zsh — Lazy-load mise (Rust version manager)
#

if [[ -x "$HOME/.local/bin/mise" ]]; then
  mise() {
    # Remove the stub function so future calls go directly to mise
    unfunction mise 2>/dev/null

    # Activate mise (sets PATH, shims, completions, environment vars)
    eval "$($HOME/.local/bin/mise activate zsh)"

    # Optional: show a one-time success message
    echo -e "\033[0;32mmise loaded successfully\033[0m"

    # If no arguments were given → just load mise and return
    if [[ $# -eq 0 ]]; then
      return 0
    fi

    # If arguments were given → forward them to the real mise binary
    command mise "$@"
  }
fi
