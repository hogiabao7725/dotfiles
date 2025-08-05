# ~/.config/zsh/lib/99_zsh_compile.zsh

function zsh_compile_all() {
    echo "Compiling .zshrc..."
    zcompile ~/.zshrc
    echo "Compiling library files..."
    zcompile ~/.config/zsh/lib/*.zsh
    echo "Zsh configuration compiled successfully."
}

alias zshcompile='zsh_compile_all'
