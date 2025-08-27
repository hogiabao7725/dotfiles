
# ------------------------------------------------------------------------------
# 1) Instant prompt (must be at the absolute top)
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 2) Optional profiler (keep as-is; enables zprof when needed)
# ------------------------------------------------------------------------------
#zmodload zsh/zprof

# ------------------------------------------------------------------------------
# 3) Paths to plugins and personal library
# ------------------------------------------------------------------------------
export ZSH_PLUGINS_DIR="$HOME/.config/zsh/plugins"
export ZSH_LIB_DIR="$HOME/.config/zsh/lib"

# ------------------------------------------------------------------------------
# 4) Completion: initialize early (before themes/plugins)
# ------------------------------------------------------------------------------
autoload -Uz compinit
if [[ ! -f ~/.zcompdump || ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  compinit -i -d ~/.zcompdump
  zcompile ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

# ------------------------------------------------------------------------------
# 5) Personal library: source all *.zsh from lib/
# ------------------------------------------------------------------------------
if [ -d "$ZSH_LIB_DIR" ]; then
  # N: no error if no match, .: regular files only
  for lib_file in "$ZSH_LIB_DIR"/*.zsh(N.); do
    source "$lib_file"
  done
  unset lib_file
fi

# ------------------------------------------------------------------------------
# 6) Theme (Powerlevel10k) — load before syntax highlighting
# ------------------------------------------------------------------------------
if [ -d "$ZSH_PLUGINS_DIR" ]; then
  source "$ZSH_PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Load user Powerlevel10k configuration, if present
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------------------------
# 7) Syntax highlighting — load last
# ------------------------------------------------------------------------------
if [ -d "$ZSH_PLUGINS_DIR" ]; then
  source "$ZSH_PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

# ------------------------------------------------------------------------------
# 8) Cleanup
# ------------------------------------------------------------------------------
unset ZSH_PLUGINS_DIR ZSH_LIB_DIR

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
