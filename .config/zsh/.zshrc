
# ------------------------------------------------------------------------------
# Optional profiler (keep as-is; enables zprof when needed)
# ------------------------------------------------------------------------------
# zmodload zsh/zprof

# ------------------------------------------------------------------------------
# Paths to plugins and personal library
# ------------------------------------------------------------------------------
export ZSH_PLUGINS_DIR="$HOME/.config/zsh/plugins"
export ZSH_LIB_DIR="$HOME/.config/zsh/lib"

# ------------------------------------------------------------------------------
# Mise: manager versions
# ------------------------------------------------------------------------------
# eval "$($(which mise) activate zsh --shims)"
eval "$($(which mise) activate zsh)"

# ------------------------------------------------------------------------------
# Completion: initialize early (before themes/plugins)
# ------------------------------------------------------------------------------
autoload -Uz compinit
if [[ ! -f ~/.zcompdump || ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  compinit -i -d ~/.zcompdump
  zcompile ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

# ------------------------------------------------------------------------------
# Personal library: source all *.zsh from lib/
# ------------------------------------------------------------------------------
if [ -d "$ZSH_LIB_DIR" ]; then
  # N: no error if no match, .: regular files only
  for lib_file in "$ZSH_LIB_DIR"/*.zsh(N.); do
    source "$lib_file"
  done
  unset lib_file
fi

# ------------------------------------------------------------------------------
# Theme (Starship) — load before syntax highlighting
# ------------------------------------------------------------------------------
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# Syntax highlighting — load last
# ------------------------------------------------------------------------------
if [ -d "$ZSH_PLUGINS_DIR" ]; then
  source "$ZSH_PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

source /home/hogiabao/Documents/Projects/sheek/script/keybinds.zsh

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------
unset ZSH_PLUGINS_DIR ZSH_LIB_DIR

# Lister history wrapper
export LISTER_HISTORY_DIR="/home/hogiabao/Documents/Projects/Lister"
source "/home/hogiabao/Documents/Projects/Lister/lister_history.sh"
