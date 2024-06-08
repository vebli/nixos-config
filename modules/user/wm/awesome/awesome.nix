{config, pkgs, pkgs-unstable, ...}:
{
    
    imports = [
        ../rofi/rofi.nix
    ];

    home.file."awesome" = {
        source = ./conf;
        target = ".config/awesome";
        recursive = true;
    };

    home.packages = with pkgs; [
        nitrogen
        picom
        xclip
        acpi
        brightnessctl
    ];
}
