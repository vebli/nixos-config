{config, pkgs, pkgs-unstable, lib, fn, nvim, ... }:
{
    users.users.vebly = {
            isNormalUser = true;
            description = "vebly";
            extraGroups = [ "networkmanager" "wheel"];
            initialPassword = "123";
    };

    home-manager = {
        users.vebly = {
            #inherit imports;
	    imports = [
            nvim.homeManagerModule
            ../../modules/user/sh/zsh/zsh.nix
            ../../modules/user/wm/awesome.nix 
            ../../modules/user/apps/kitty.nix
            ../../modules/user/apps/tmux.nix
            ../../modules/user/apps/latex.nix
            ../../modules/user/apps/librewolf.nix
        ];
            home.stateVersion = "24.05"; 

            home.packages = with pkgs; [
                discord
                    arandr
                    freetube
                    obsidian
                    dbeaver-bin
                    octaveFull
            ];

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
