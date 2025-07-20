{pkgs, wallpaperPath, ...}: pkgs.writeShellScriptBin "random-wallpaper" /*bash*/ ''
    WALLPAPER_DIR=${wallpaperPath}
    RANDOM_WALLPAPER=$(find -L $WALLPAPER_DIR -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    case $1 in 
        feh) 
            feh --bg-fill $RANDOM_WALLPAPER&;;
        sway)
            swaybg -i $RANDOM_WALLPAPER -m fill 2> /dev/null&;;
    esac
''
