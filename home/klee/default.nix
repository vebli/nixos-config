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
                ../../modules/user/sh/zsh/zsh.nix
                ../../modules/user/apps/librewolf.nix
            ];
            home.username = "klee";
            home.homeDirectory = "/home/klee";


            home.stateVersion = "24.05"; 

            home.packages = with pkgs; [
                freetube
                obsidian
		ytdownloader
		mpv
		okular
            ];

            home.sessionVariables = {
                EDITOR = "nvim";
            };
# Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
        };
    };
}
