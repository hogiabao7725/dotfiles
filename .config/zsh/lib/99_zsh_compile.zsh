# ~/.config/zsh/lib/99_zsh_compile.zsh

# ---------------------------
# Option parser (reusable, no globals)
# ---------------------------
_zsh_parse_opts() {
  emulate -L zsh
  setopt local_options

  local quiet=0 usage_msg="$1"
  shift

  while [[ $1 == -* ]]; do
    case $1 in
      -q|--quiet) quiet=1 ;;
      -h|--help)
        print "$usage_msg"
        return 1 ;;
      *) print "Unknown option: $1" >&2; return 2 ;;
    esac
    shift
  done

  # Echo so caller can capture it
  echo $quiet
  return 0
}

# ---------------------------
# Compile Zsh files
# ---------------------------
zsh_compile() {
  emulate -L zsh
  setopt nullglob local_options

  local usage="Usage: zsh_compile [-q|--quiet] [-h|--help]
Compile Zsh files into .zwc bytecode for faster startup"

  local quiet; quiet=$(_zsh_parse_opts "$usage" "$@") || return $?

  local -a files success_files failed_files
  local f zwc_file
  local -i compiled=0 failed=0

  files=(~/.zshrc ~/.config/zsh/lib/*.zsh)

  (( quiet )) || print "⚡ Starting Zsh compilation..."

  for f in $files; do
    [[ -f $f && -r $f ]] || continue
    zwc_file="${f}.zwc"

    # Skip if already up-to-date
    [[ -f $zwc_file && $zwc_file -nt $f ]] && continue

    # Remove old compiled files
    rm -f "$zwc_file" "${zwc_file}.old"

    if zcompile "$f" 2>/dev/null; then
      success_files+=("$f")
      ((compiled++))
    else
      failed_files+=("$f")
      ((failed++))
    fi
  done

  if (( !quiet )); then
    if (( compiled > 0 )); then
      print "✓ Compiled $compiled file(s):"
      printf "  %s\n" $success_files
    fi

    if (( failed > 0 )); then
      print "✗ Failed $failed file(s):" >&2
      printf "  %s\n" $failed_files >&2
    fi

    if (( compiled == 0 && failed == 0 )); then
      print "All files are already up to date."
    fi
  fi

  return $failed
}

# ---------------------------
# Clean compiled files
# ---------------------------
zsh_clean() {
  emulate -L zsh
  setopt nullglob local_options

  local usage="Usage: zsh_clean [-q|--quiet] [-h|--help]
Remove all compiled Zsh .zwc files"

  local quiet; quiet=$(_zsh_parse_opts "$usage" "$@") || return $?

  local -a zwc_files=(
    ~/.zshrc.zwc
    ~/.config/zsh/lib/*.zsh.zwc
    ~/.config/zsh/lib/*.zsh.zwc.old
  )
  local f
  local -i removed=0

  if (( ${#zwc_files[@]} == 0 )); then
    (( quiet )) || print "No compiled files found."
    return 0
  fi

  (( quiet )) || print "🧹 Cleaning compiled files..."

  for f in $zwc_files; do
    [[ -f $f ]] || continue
    rm -f "$f" && ((removed++))
    (( quiet )) || print "  Removed: $f"
  done

  (( quiet )) || print "✓ Cleaned $removed file(s)."
  return 0
}

# ---------------------------
# Recompile = clean + compile
# ---------------------------
zsh_recompile() {
  emulate -L zsh

  local usage="Usage: zsh_recompile [-q|--quiet] [-h|--help]
Clean and recompile all Zsh files"

  local quiet; quiet=$(_zsh_parse_opts "$usage" "$@") || return $?

  local -a opts
  (( quiet )) && opts+=(-q)

  zsh_clean "${opts[@]}"
  zsh_compile "${opts[@]}"
}

# ---------------------------
# Status check
# ---------------------------
zsh_status() {
  emulate -L zsh
  setopt nullglob local_options

  local -a files
  local f zwc_file
  local -i total=0 compiled=0 outdated=0

  files=(~/.zshrc ~/.config/zsh/lib/*.zsh)

  print "📊 Zsh compilation status:"

  for f in $files; do
    [[ -f $f ]] || continue
    ((total++))
    zwc_file="${f}.zwc"

    if [[ -f $zwc_file ]]; then
      if [[ $zwc_file -nt $f ]]; then
        ((compiled++))
        print "  ✓ $f"
      else
        ((outdated++))
        print "  ⚠ $f (outdated)"
      fi
    else
      print "  ✗ $f (not compiled)"
    fi
  done

  print "\nSummary: $compiled/$total compiled, $outdated outdated"
  (( compiled < total )) && print "💡 Run 'zshcompile' to improve startup performance"

  return 0
}

# ---------------------------
# Aliases
# ---------------------------
alias zshcompile='zsh_compile'
alias zshclean='zsh_clean'
alias zshrecompile='zsh_recompile'
alias zshstatus='zsh_status'

# Quick shortcuts
alias zc='zsh_compile -q'
alias zr='zsh_recompile -q'
