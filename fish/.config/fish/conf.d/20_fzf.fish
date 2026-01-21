# ~/.config/fish/conf.d/20_fzf.fish

if not status is-interactive
    exit
end

# Skip if fzf is not installed
if not command -q fzf
    exit
end

# ---------- Sources (using fd as backend) ----------
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND  'fd --type d --hidden --follow --exclude .git --exclude node_modules'

# ---------- Theme: TokyoNight Storm ----------
# Standard Palette References:
# bg            = #24283b
# bg_dark       = #1f2335
# bg_highlight  = #292e42
# fg            = #c0caf5
# blue          = #7aa2f7
# cyan          = #7dcfff
# green         = #9ece6a
# yellow        = #e0af68

set -l fzf_colors "\
--color=fg:#c0caf5,bg:,hl:#9ece6a \
--color=fg+:#c0caf5,bg+:#1f2335,hl+:#9ece6a:bold \
--color=info:#e0af68,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#e0af68 \
--color=gutter:#24283b,border:#7aa2f7,preview-bg:"

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

# ---------- Ctrl+T: files + preview ----------
set -gx FZF_CTRL_T_OPTS "\
--preview 'bat --color=always --style=numbers --line-range=:500 {}' \
--preview-window=right:60%:border-left:wrap \
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ---------- Ctrl+R: history ----------
set -gx FZF_CTRL_R_OPTS "\
--no-sort \
--exact \
--height=16 \
--border=rounded \
--prompt='History ❯ '"

# ---------- Alt+C: directories + tree preview ----------
set -gx FZF_ALT_C_OPTS "\
--preview 'eza --tree --level=2 --icons --color=always {}' \
--preview-window=right:50%:border-left \
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ---------- Enable keybindings ----------
if functions -q fzf_key_bindings
    fzf_key_bindings
end