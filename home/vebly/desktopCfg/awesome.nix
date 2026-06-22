{config, pkgs, pkgs-unstable, lib, var, inputs, ...}:
{
    imports = [ ./rofi ];  
    xsession.windowManager.awesome = {
        enable = true;
        package = pkgs.awesome;
        luaModules = with pkgs.lua54Packages; [vicious lgi];
    };

    gtk = {
        enable = true;
        theme.name = "Adwaita-dark"; 
        theme.package = pkgs.gnome-themes-extra;
    };

    home.file."awesome" = {
        source = inputs.awesome-config.outPath;
        target = ".config/awesome";
        recursive = true;
    };

    home.file={
        "wallpapers" = {
            source = inputs.wallpapers.outPath;
            target = lib.strings.removePrefix "~/" var.path.wallpapers; 
            recursive = true;
        };
    };

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "application/pdf" = "org.pwmt.zathura.desktop";
        };
    };

    home.packages = with pkgs; [
        (thunar.override{thunarPlugins = [
            thunar-archive-plugin
            thunar-media-tags-plugin
            thunar-volman
            thunar-shares-plugin
        ];})
        xarchiver # Winrar type program
        gdk-pixbuf # Something related to thumbnail generation
        ffmpegthumbnailer # video thumbnail generation
        poppler # pdf preview

        dconf # Required when enabling gtk
        shutter
        networkmanagerapplet
        pavucontrol
        nitrogen
        feh
        picom
        xclip
        brightnessctl
        arandr
    ];

}
