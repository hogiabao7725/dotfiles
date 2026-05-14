function fish_greeting
    # Skip inside editors
    if test "$TERM_PROGRAM" = "vscode"
        return
    end

    if test "$TERM_PROGRAM" = "zed"
        return
    end

    # Skip non-interactive shell
    status is-interactive; or return

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
