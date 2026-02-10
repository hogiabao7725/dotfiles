# ~/.config/fish/conf.d/10_alias.fish

if not status is-interactive
    exit
end

if command -q eza
    alias ls 'eza --icons'
    alias ll 'eza --icons -laF --git'
    alias la 'eza --icons -aF'
    alias l  'eza --icons -CF'
    alias tree 'eza -T --icons'
else
    alias ls 'ls --color=auto'
    alias ll 'ls -alF'
    alias la 'ls -A'
    alias l  'ls -CF'
end

abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

alias grep 'grep --color=auto'