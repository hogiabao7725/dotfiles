# ~/.config/fish/conf.d/90_starship.fish

if not status is-interactive
    exit
end

if not command -q starship
    exit
end

starship init fish | source
