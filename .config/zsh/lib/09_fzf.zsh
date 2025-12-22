# #
# # 09_fzf.zsh - FZF History Search Only (lazy load, clean)
# #

# Exit if fzf is not installed
command -v fzf >/dev/null 2>&1 || return

# Only run in interactive shells
[[ $- != *i* ]] && return

# Custom FZF options for Ctrl+R (history search)
export FZF_CTRL_R_OPTS="--no-sort --exact --reverse --height=15 \
  --border --ansi --color=border:bright-white,hl:bright-green"

# Loader: source fzf key-bindings once
_fzf_load() {
  emulate -L zsh
  [[ -r "$HOME/.config/zsh/plugins/key-bindings.zsh" ]] && source "$HOME/.config/zsh/plugins/key-bindings.zsh"

  # Remove this function after first load (no overhead next time)
  unfunction _fzf_load 2>/dev/null

  # Remove unwanted default bindings (Ctrl-T, Alt-C)
  bindkey -r '^T' 2>/dev/null   # remove fzf-file-widget
  bindkey -r '\ec' 2>/dev/null  # remove fzf-cd-widget (Alt-C)
}

# Lazy stub: first call triggers loader, then rebinds to real widget
_fzf_history_widget_lazy() {
  _fzf_load
  # Replace stub with real widget
  zle -N fzf-history-widget
  # Forward call to the real widget
  zle fzf-history-widget -- "$@"
}

# Register stub as initial widget
zle -N fzf-history-widget _fzf_history_widget_lazy

# Key binding: Ctrl+R
bindkey '^R' fzf-history-widget
