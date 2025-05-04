{pkgs, ...}:
pkgs.writeShellScriptBin "__toggle_kb_lang" /*bash*/''
  current_language=$(setxkbmap -print | grep xkb_symbols | awk -F"+" '{print $2}')
  if [ "$current_language" == "us" ]; then
      setxkbmap ch
  else
      setxkbmap us
  fi
''
