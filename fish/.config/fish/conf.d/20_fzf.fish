# Only run in interactive mode
if not status is-interactive
    exit
end

# Exit if fzf is missing
if not command -q fzf
    exit
end

# --- 1. Init ---
fzf --fish | source

# --- 2. Logic (fd) ---
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND  'fd --type d --hidden --follow --exclude .git --exclude node_modules'

# --- 3. Theme (Catppuccin Mocha) ---
set -l fzf_colors "\
--color=fg:#cdd6f4,bg:,hl:#cba6f7 \
--color=fg+:#cdd6f4,bg+:#313244,hl+:#cba6f7:bold:underline \
--color=info:#f9e2af,prompt:#89b4fa,pointer:#f38ba8 \
--color=marker:#f38ba8,spinner:#f38ba8,header:#fab387 \
--color=gutter:#1e1e2e,border:#89b4fa,preview-bg:"

set -gx FZF_DEFAULT_OPTS "\
--style=full \
--height=70% \
--layout=reverse \
--border=rounded \
--info=inline-right \
--prompt='❯ ' \
--pointer='▶' \
--marker='✓' \
$fzf_colors"

# --- 4. Previews (bat & eza) ---

# Ctrl+T: File Preview (bat)
set -gx FZF_CTRL_T_OPTS "\
--preview 'bat --color=always --style=numbers --line-range=:500 {}' \
--preview-window=right:60%:border-left:wrap \
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Ctrl+R: History
set -gx FZF_CTRL_R_OPTS "\
--no-sort \
--exact \
--height=16 \
--border=rounded \
--prompt='History ❯ ' \
--delimiter=' │ ' \
--with-nth=2.."

# Alt+C: Directory Preview (eza)
set -gx FZF_ALT_C_OPTS "\
--preview 'eza --tree --level=2 --icons --color=always {}' \
--preview-window=right:50%:border-left \
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# --- 5. Activation ---
fzf_key_bindings
