# ==============================================================================
#                             My Zsh Conductor
# ==============================================================================

# zmodload zsh/zprof

# ------------------------------------------------------------------------------
# 1. Performance First: Instant Prompt
#    Must be at the absolute top to work correctly.
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ------------------------------------------------------------------------------
# 2. Declarations: Define core paths
#    Centralize path definitions for easy maintenance.
# ------------------------------------------------------------------------------
export ZSH_PLUGINS_DIR="$HOME/.config/zsh/plugins"
export ZSH_LIB_DIR="$HOME/.config/zsh/lib"


# ------------------------------------------------------------------------------
# 3. Core Activation: Load essential plugins
#    Source a few fundamental plugins directly for clarity.
# ------------------------------------------------------------------------------
if [ -d "$ZSH_PLUGINS_DIR" ]; then
  source "$ZSH_PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme"
  source "$ZSH_PLUGINS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
  # Add other core plugins here if needed.
fi


# ------------------------------------------------------------------------------
# 4. Personalization: Load custom configurations from lib/
#    Automatically sources all *.zsh files from your library directory.
# ------------------------------------------------------------------------------
if [ -d "$ZSH_LIB_DIR" ]; then
  # Use Zsh's glob qualifiers (N.) for safety:
  # N = No error if no files match.
  # . = Regular files only.
  for lib_file in "$ZSH_LIB_DIR"/*.zsh(N.); do
    source "$lib_file"
  done
  unset lib_file
fi


# ------------------------------------------------------------------------------
# 5. Finalization: Run post-setup commands
#    Initialize components that need to run after everything else is loaded.
# ------------------------------------------------------------------------------
# Initialize the completion system.
autoload -Uz compinit
compinit -i -C

# Load the Powerlevel10k user configuration file.
# This must be last to apply all personal theme settings.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# --- Cleanup ---
# Unset temporary variables to keep the interactive session clean.
unset ZSH_PLUGINS_DIR ZSH_LIB_DIR
