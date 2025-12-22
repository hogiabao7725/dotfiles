# #
# # 40_keybindings.zsh
# # Defines custom keybindings.
# #
#
# # --- History Search ---
# # Start searching history by typing a command and pressing Up/Down arrows.
# bindkey '^[OA' history-beginning-search-backward
# bindkey '^[OB' history-beginning-search-forward
#
# # --- Navigation ---
# # Allow Home and End keys to go to the beginning/end of the line.
# bindkey '^[[H' beginning-of-line  # Home key
# bindkey '^[[F' end-of-line        # End key
# bindkey '^[[1~' beginning-of-line # Alternative Home key
# bindkey '^[[4~' end-of-line        # Alternative End key
#
# # Allow Ctrl + Left/Right Arrow to move by one word.
# bindkey '^[[1;5D' backward-word
# bindkey '^[[1;5C' forward-word
#
# # --- Editing ---
# # Bind Ctrl+L to clear the screen
# bindkey '^L' clear-screen
