#
# 08_fzf.zsh - Lightweight FZF Integration (no plugin manager)
#

# Add FZF binary to PATH (required)
export PATH="$HOME/.config/zsh/plugins/fzf/bin:$PATH"

source "$HOME/.config/zsh/plugins/fzf/shell/key-bindings.zsh"
source "$HOME/.config/zsh/plugins/fzf/shell/completion.zsh"

typeset -gA FAST_HIGHLIGHT
FAST_HIGHLIGHT[widget_list]="fzf-file-widget fzf-history-widget"
