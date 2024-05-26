{config, pkgs, pkgs-unstable, ... }:
{
    home.file."tpm" = {
        source = ./conf;
        target = ".tmux";
        recursive = true;
    };
    home.file."tmux" = {
        source = ./tmux.conf;
        target = ".tmux.conf";
    };
}
