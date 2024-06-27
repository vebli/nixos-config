{config, pkgs, pkgs-unstable, lib, fn, nvim, ... }:
{
    users.users.klee = {
        isNormalUser = true;
        extraGroups = ["networkmanager"];
        initialPassword = "123";
    };
    home-manager = let 
        imports = fn.imports[ 
        nvim.homeManagerModule
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
    };
}
