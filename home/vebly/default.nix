{config, pkgs, pkgs-unstable, lib, var, inputs, ... }:
{
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
            ../../modules/user/wm/awesome.nix 
            ../../modules/user/dev
            ../../modules/user/apps/kitty.nix
            ../../modules/user/apps/tmux.nix
            ../../modules/user/apps/latex.nix
            ../../modules/user/apps/librewolf.nix
            ../../modules/user/apps/matlab.nix
        ];
            home.username = "vebly";
            home.homeDirectory = "/home/vebly";

            home.stateVersion = "24.05"; 
            home.packages = with pkgs; [
                discord
                arandr
                obsidian
                dbeaver-bin
                octaveFull

                ani-cli
                manga-cli
                mpv

                # Office
                okular
                zathura


            ] ++ (with pkgs-unstable;[
                    freetube
                    ytmdl
            ]);

            programs.git = {
                enable = true;
                userName = "vebly";
                userEmail = "";
            };

            home.sessionVariables = {
                EDITOR = "nvim";
            };
            home.file."wallpapers" = {
                source = inputs.wallpapers.outPath;
                target = lib.strings.removePrefix "~/" var.wallpaperPath; 
                recursive = true;
            };
# Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
        };
    };
}
