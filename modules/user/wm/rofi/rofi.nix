{pkgs, ...}:
{
    home.packages = with pkgs;[
        rofi
    ];

    home.file."rofi" = {
        source = ./conf;
        target = ".config/rofi";
        recursive = true;
    };
}
