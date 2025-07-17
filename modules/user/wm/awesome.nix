{config, pkgs, pkgs-unstable, inputs, ...}:
{
    imports = [
        ./rofi
    ];  
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
    home.packages = with pkgs; [
        nemo-with-extensions
        dconf # Required when enabling gtk
        networkmanagerapplet
        pavucontrol
        nitrogen
        feh
        picom
        xclip
        brightnessctl
    ];

}
