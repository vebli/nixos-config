{pkgs, wallpaperPath, ...}: pkgs.writeShellScriptBin "random-wallpaper" /*bash*/ ''
    WALLPAPER_DIR=${wallpaperPath}
    RANDOM_WALLPAPER=$(find -L $WALLPAPER_DIR -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    feh --bg-fill $RANDOM_WALLPAPER
''
