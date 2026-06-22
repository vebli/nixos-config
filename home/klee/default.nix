{config, pkgs, pkgs-unstable, lib, fn, ... }:
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
                ../vebly/zsh.nix
            ];
            home.username = "klee";
            home.homeDirectory = "/home/klee";


            home.stateVersion = "24.05"; 

            home.packages = with pkgs; [
                obsidian
                ytdownloader
                mpv
                kdePackages.okular
            ];

            programs.librewolf = {
                enable = true;
                languagePacks = ["en-GB" "de"];
            };

            home.sessionVariables = {
                EDITOR = "nvim";
            };
            programs.home-manager.enable = true;
        };
    };
}
