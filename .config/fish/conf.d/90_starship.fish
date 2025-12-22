# ~/.config/fish/conf.d/90_starship.fish

if status is-interactive
    if type -q starship
        starship init fish | source
    end
end
