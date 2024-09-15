{config, pkgs, pkgs-unstable, lib, var, inputs, ... }:
let 
    cfg = config.opt.vebly;
in
{
    options.opt.vebly = {
        desktopCfg = lib.mkOption {
            default = true;
        };
    };
    config = {
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
                ] ++ (if cfg.desktopCfg then ([
                        ../../modules/user/wm/awesome.nix 
                        ../../modules/user/apps/matlab.nix
                        ../../modules/user/apps/latex.nix
                        ../../modules/user/apps/librewolf.nix
                        ../../modules/user/apps/kitty.nix
                ]) else []);
                home.username = "vebly";
                home.homeDirectory = "/home/vebly";

                home.stateVersion = "24.05"; 
                home.packages = lib.mkIf cfg.desktopCfg (with pkgs; [
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
                ]));

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
    };
}
