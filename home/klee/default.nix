{config, pkgs, pkgs-unstable, lib, fn, wallpapers, ... }:
{
    users.users.klee = {
        isNormalUser = true;
        extraGroups = ["networkmanager"];
        initialPassword = "123";
    };
    home-manager = 
    {
        users.klee = {
            imports = [
                ../../modules/user/sh/zsh/zsh.nix
                ../../modules/user/apps/librewolf.nix
            ];
            home.username = "klee";
            home.homeDirectory = "/home/klee";


            home.stateVersion = "24.05"; 

            home.packages = with pkgs; [
                freetube
                obsidian
            ];

            home.file."wallpapers" = {
                source = wallpapers.outPath;
                target = "Pictures/Wallpapers";
                recursive = true;
            };


            home.sessionVariables = {
                EDITOR = "nvim";
            };
# Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
        };
    };
}
