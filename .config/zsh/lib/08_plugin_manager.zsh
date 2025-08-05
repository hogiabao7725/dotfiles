#!/bin/zsh
# ==============================================================================
#                          ZSH Plugin Manager
# ==============================================================================
# A simple, modular, and clean Zsh plugin management system.

# ------------------------------------------------------------------------------
# Setup & Configuration
# ------------------------------------------------------------------------------

# Load Zsh's native color module for clean output.
autoload -U colors && colors

# Define a clean color palette for consistent messaging.
C_TITLE=$fg_bold[blue]
C_CMD=$fg[green]
C_ARG=$fg[cyan]
C_SUCCESS=$fg[green]
C_ERROR=$fg[red]
C_WARN=$fg[yellow]
C_INFO=$fg[blue]
C_RESET=$reset_color

# This array is the single source of truth for all your plugins.
# Format: "local-directory-name github-user/repo file-to-source"
ZSH_PLUGINS=(
  "powerlevel10k romkatv/powerlevel10k"
  "fast-syntax-highlighting zdharma-continuum/fast-syntax-highlighting"
  "fzf junegunn/fzf"
  # "zsh-autosuggestions zsh-users/zsh-autosuggestions zsh-autosuggestions.zsh"
)

# The directory where all plugins will be installed.
PLUGINS_DIR="$HOME/.config/zsh/plugins"


# ------------------------------------------------------------------------------
# Helper Functions (Internal Logic)
# ------------------------------------------------------------------------------

# Finds the full data string for a given plugin name from the ZSH_PLUGINS array.
_zplugins_find_data() {
  local search_name="$1"
  for plugin_data in "${ZSH_PLUGINS[@]}"; do
    if [[ "${plugin_data%% *}" == "$search_name" ]]; then
      echo "$plugin_data"
      return 0
    fi
  done
  return 1
}

# Installs a single plugin.
_zplugins_install() {
  local name="$1"
  local plugin_data
  plugin_data=$(_zplugins_find_data "$name")

  if [[ -z "$plugin_data" ]]; then
    echo "${C_ERROR}Error:${C_RESET} Plugin '${C_ARG}$name${C_RESET}' not found in your configuration list." >&2
    return 1
  fi

  local repo
  read -r _ repo _ <<< "$plugin_data"
  local dest="$PLUGINS_DIR/$name"

  if [ -d "$dest" ]; then
    echo "${C_INFO}Info:${C_RESET} Plugin '${C_ARG}$name${C_RESET}' is already installed."
  else
    echo "Installing '${C_ARG}$name${C_RESET}' from '$repo'..."
    if git clone --depth 1 "https://github.com/$repo.git" "$dest"; then
      echo "${C_SUCCESS}Success:${C_RESET} Plugin '${C_ARG}$name${C_RESET}' has been installed."
    else
      echo "${C_ERROR}Error:${C_RESET} Failed to clone '${C_ARG}$name${C_RESET}' from repository '$repo'." >&2
      return 1
    fi
  fi
}

# Updates a single plugin.
_zplugins_update() {
  local name="$1"
  local dest="$PLUGINS_DIR/$name"
  if [ -d "$dest" ]; then
    echo "Updating '${C_ARG}$name${C_RESET}'..."
    (cd "$dest" && git pull)
  else
    echo "${C_WARN}Warning:${C_RESET} Plugin '${C_ARG}$name${C_RESET}' is not installed. Use 'zplugins install $name' first."
  fi
}

# Updates all configured plugins.
_zplugins_update_all() {
  echo "${C_TITLE}Updating all configured plugins...${C_RESET}"
  for plugin_data in "${ZSH_PLUGINS[@]}"; do
    local name="${plugin_data%% *}"
    _zplugins_update "$name"
  done
  echo "${C_SUCCESS}All plugins are up to date.${C_RESET}"
}

# Cleans a single specified orphaned plugin directory.
_zplugins_clean_single() {
  local name="$1"
  local dest="$PLUGINS_DIR/$name"

  if [ ! -d "$dest" ]; then
    echo "${C_INFO}Info:${C_RESET} Plugin directory '${C_ARG}$name${C_RESET}' does not exist. Nothing to clean."
    return 0
  fi

  if _zplugins_find_data "$name" &>/dev/null; then
    echo "${C_ERROR}Error:${C_RESET} Plugin '${C_ARG}$name${C_RESET}' is still present in your configuration." >&2
    echo "Please remove it from the ZSH_PLUGINS array before cleaning." >&2
    return 1
  fi

  echo "${C_WARN}Orphaned plugin found:${C_RESET} $name"
  read -q "REPLY?Do you want to permanently delete this directory? ${C_BOLD}[y/N]${C_RESET} "
  echo ""
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "-> Deleting '${C_ARG}$name${C_RESET}'..."
    rm -rf "$dest"
    echo "${C_SUCCESS}Success:${C_RESET} '${C_ARG}$name${C_RESET}' has been deleted."
  else
    echo "Cleanup for '${C_ARG}$name${C_RESET}' cancelled."
  fi
}

# Scans for and cleans all orphaned plugins.
_zplugins_clean_all() {
  echo "${C_TITLE}Scanning for all orphaned plugins...${C_RESET}"
  typeset -A valid_plugins
  for plugin_data in "${ZSH_PLUGINS[@]}"; do
    local name="${plugin_data%% *}"
    valid_plugins[$name]=1
  done

  for dir in $PLUGINS_DIR/*; do
    if [ -d "$dir" ]; then
      local dir_name=$(basename "$dir")
      if [[ -z "${valid_plugins[$dir_name]}" ]]; then
        _zplugins_clean_single "$dir_name"
      fi
    fi
  done
  echo "${C_SUCCESS}Cleanup complete.${C_RESET}"
}

# Lists all configured plugins.
_zplugins_list() {
  echo "${C_TITLE}Configured Zsh plugins:${C_RESET}"
  for plugin_data in "${ZSH_PLUGINS[@]}"; do
    local name="${plugin_data%% *}"
    echo "- ${C_INFO}$name${C_RESET}"
  done
}

# Prints the help message.
_zplugins_help() {
  echo "${C_TITLE}Zsh Plugin Manager${C_RESET}"
  echo "A simple, script-based manager for your Zsh plugins."
  echo
  echo "${C_BOLD}Usage:${C_RESET} zplugins ${C_CMD}<command>${C_RESET} ${C_ARG}[arguments...]${C_RESET}"
  echo
  echo "${C_BOLD}Commands:${C_RESET}"
  echo "  ${C_CMD}install${C_RESET} ${C_ARG}<plugin_name>${C_RESET}    Install a single new plugin."
  echo "  ${C_CMD}install${C_RESET} ${C_ARG}--all${C_RESET}            Install all missing plugins (for new machines)."
  echo "  ${C_CMD}update${C_RESET}  ${C_ARG}<plugin_name>${C_RESET}     Update a specific plugin."
  echo "  ${C_CMD}update${C_RESET}  ${C_ARG}--all${C_RESET}             Update all configured plugins."
  echo "  ${C_CMD}clean${C_RESET}   ${C_ARG}<plugin_name>${C_RESET}      Remove a specific orphaned plugin."
  echo "  ${C_CMD}clean${C_RESET}   ${C_ARG}--all${C_RESET}              Remove all non-configured plugins."
  echo "  ${C_CMD}list${C_RESET}                     List all configured plugins."
  echo "  ${C_CMD}help${C_RESET}                     Show this help message."
}


# ------------------------------------------------------------------------------
# Main Dispatcher Function (The User-Facing Command)
# ------------------------------------------------------------------------------

zplugins() {
  local command="$1"
  local target_name="$2"

  case "$command" in
    install)
      if [[ "$target_name" == "--all" ]]; then
        for plugin_data in "${ZSH_PLUGINS[@]}"; do
          _zplugins_install "${plugin_data%% *}"
        done
        echo "${C_SUCCESS}Initial installation complete. Restart your shell for changes to take effect.${C_RESET}"
      elif [[ -n "$target_name" ]]; then
        _zplugins_install "$target_name"
      else
        _zplugins_help
      fi
      ;;
    update)
      if [[ "$target_name" == "--all" ]]; then _zplugins_update_all
      elif [[ -n "$target_name" ]]; then _zplugins_update "$target_name"
      else _zplugins_help
      fi
      ;;
    clean)
      if [[ "$target_name" == "--all" ]]; then _zplugins_clean_all
      elif [[ -n "$target_name" ]]; then _zplugins_clean_single "$target_name"
      else _zplugins_help
      fi
      ;;
    list)
      _zplugins_list
      ;;
    help|--help|-h|*)
      _zplugins_help
      ;;
  esac
}
