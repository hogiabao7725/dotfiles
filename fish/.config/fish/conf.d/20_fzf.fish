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

# ---------- Theme: Catppuccin Mocha ----------
# Standard Palette References:
# bg            = #1e1e2e
# bg_dark       = #181825
# bg_highlight  = #313244
# fg            = #cdd6f4
# blue          = #89b4fa
# cyan          = #89dceb
# green         = #a6e3a1
# yellow        = #f9e2af
# pink          = #f5c2e7
# mauve         = #cba6f7
# red           = #f38ba8
# peach         = #fab387

set -l fzf_colors "\
--color=fg:#cdd6f4,bg:,hl:#a6e3a1 \
--color=fg+:#cdd6f4,bg+:#313244,hl+:#a6e3a1:bold \
--color=info:#f9e2af,prompt:#89dceb,pointer:#f5c2e7 \
--color=marker:#a6e3a1,spinner:#a6e3a1,header:#fab387 \
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
