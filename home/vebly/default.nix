{config, pkgs, pkgs-unstable, lib, var, inputs, ... }:
{
    imports = [
        ./desktopCfg.nix
        ./syncthing.nix
    ];
    users.users.vebly = {
        isNormalUser = true;
        description = "vebly";
        extraGroups = [ "networkmanager" "wheel" "dialout" "syncthing"];
        initialPassword = "123";
    };

    home-manager = {
        users.vebly = {
            imports = [
                ../../modules/user/sh/zsh/zsh.nix
                    ../../modules/user/dev
                    ../../modules/user/apps/tmux.nix
            ];

            home.username = "vebly";
            home.homeDirectory = "/home/vebly";

            home.stateVersion = "24.05"; 

            programs.git = {
                enable = true;
                userName = "vebly";
                userEmail = "";
            };

            home.sessionVariables = {
                EDITOR = "nvim";
            };
# Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
        };
    };
}
