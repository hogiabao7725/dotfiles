# ~/.config/fish/conf.d/05_mise.fish

if status is-interactive
    if type -q mise
        mise activate fish | source
    end
end
