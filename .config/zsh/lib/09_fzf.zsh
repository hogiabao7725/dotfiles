# #
# # 09_fzf.zsh - Lightweight FZF Integration (no plugin manager)
# #

# Base path to your local fzf (change if needed)
local FZF_BASE="$HOME/.config/zsh/plugins/fzf"

# Add fzf binary to PATH if present
[[ -x "$FZF_BASE/bin/fzf" ]] && export PATH="$FZF_BASE/bin:$PATH"

# Only for interactive shells
[[ $- != *i* ]] && return

# Loader: source fzf bindings & completion exactly once
_fzf_load() {
  emulate -L zsh
  [[ -r "$FZF_BASE/shell/key-bindings.zsh" ]] && source "$FZF_BASE/shell/key-bindings.zsh"
  [[ -r "$FZF_BASE/shell/completion.zsh"   ]] && source "$FZF_BASE/shell/completion.zsh"
  # Remove this function after first load (no overhead next time)
  unfunction _fzf_load 2>/dev/null
}

# Stub widgets: first press triggers load, then re-dispatch to real widget
for _w in fzf-file-widget fzf-history-widget; do
  eval "
  ${_w}() {
    _fzf_load
    zle ${_w} -- \"\$@\"
  }
  zle -N ${_w}
  "
done

# Minimal key bindings (fzf defaults: Ctrl+T = files, Ctrl+R = history)
bindkey '^T' fzf-file-widget
bindkey '^R' fzf-history-widget

# (Optional) fast-syntax-highlighting integration
typeset -gA FAST_HIGHLIGHT
FAST_HIGHLIGHT[widget_list]="fzf-file-widget fzf-history-widget"
