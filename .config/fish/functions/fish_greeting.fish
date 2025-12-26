function fish_greeting
    if test "$TERM_PROGRAM" != "vscode"
        if type -q fastfetch
            fastfetch
        else
            set_color brcyan
            echo "╭─ Hi! $USER 🐟"
            set_color bryellow
            echo "╰─ What are you today... ✨"
            set_color normal
        end
    end
end