{config, pkgs, pkgs-unstable, lib, fn, ... }:
let 
    imports = fn.imports[ 
        ../../modules/user/apps/librewolf.nix
        ../../modules/user/sh/zsh/zsh.nix
    ];
in 
{
    inherit imports;
    home.username = "klee";
    home.homeDirectory = "/home/klee";


    home.stateVersion = "24.05"; 

    home.packages = with pkgs; [
        freetube
        obsidian
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };
# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
