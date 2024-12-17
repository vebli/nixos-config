{config, pkgs, pkgs-unstable, inputs, ...}:
{
    imports = [
        ./rofi/rofi.nix
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
        dconf # Required when enabling gtk
        nitrogen
        feh
        picom
        xclip
        acpi
        brightnessctl
    ];

}
