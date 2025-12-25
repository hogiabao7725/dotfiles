function fish_greeting
    if type -q fastfetch
        fastfetch
    else
        set_color brcyan
        echo "╭─ Hi! Ho Gia Bao 🐟"
        set_color bryellow
        echo "╰─ What are you today... ✨"
        set_color normal
    end
end