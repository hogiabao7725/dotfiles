# ~/.config/fish/conf.d/10_alias.fish

if status is-interactive

    # File & Directory Operations
    if type -q eza
        alias ls 'eza --icons'
        alias ll 'eza --icons -laF --git'
        alias la 'eza --icons -aF'
        alias l  'eza --icons -CF'
        alias tree 'eza -T --icons'
        alias tre  'eza -T -a --icons'
    else
        alias ls 'ls --color=auto'
        alias ll 'ls -alF'
        alias la 'ls -A'
        alias l  'ls -CF'
    end

    # Quick directory navigation
    abbr -a .. 'cd ..'
    abbr -a ... 'cd ../..'
    abbr -a .... 'cd ../../..'

    # Safe overwrite and delete
    alias cp 'cp -i'
    alias mv 'mv -i'
    alias rm 'rm -i'

    # Useful shortcuts
    alias grep 'grep --color=auto'
    alias df 'df -h'
    alias du 'du -h'

    # Manage dotfiles with bare git repo
    alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
end
