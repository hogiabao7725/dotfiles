# ~/.config/fish/conf.d/90_starship.fish

if not status is-interactive
    exit
end

# Skip if starship is not installed
if not command -sq fzf
    exit
end

starship init fish | source
