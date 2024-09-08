{pkgs, wallpaperPath, ...}: pkgs.writeShellScriptBin "current-wallpaper" /*bash*/ ''
    grep feh ~/.fehbg | awk -F"'" '{print $2}' | xargs basename
''
