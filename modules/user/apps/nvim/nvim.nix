{config, pkgs, pkgs-unstable, ... }:
{
    home.file."nvim" = {
        source = ./conf;
        target = ".config/nvim";
        recursive = true;
    };
}
