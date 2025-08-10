# ~/.config/zsh/lib/99_zsh_compile.zsh
zsh_recompile() {
  local files=(~/.zshrc ~/.config/zsh/lib/*.zsh)
  autoload -Uz zrecompile
  for f in $files; do
    [[ -f $f ]] || continue
    zmodload zsh/zutil
    zrecompile "$f" && print "Compiled: $f"
    [[ -f ${f}.zwc.old ]] && rm -f -- "${f}.zwc.old"
  done
  print "Done."
}
alias zshcompile='zsh_recompile'
