{ pkgs, ... }:
{
    home.packages = with pkgs; [
        zsh
    ];


    home.file = {
        "zshrc" = {
            source = ./zshrc;
            target = "./.zshrc";
        };
    };
}
