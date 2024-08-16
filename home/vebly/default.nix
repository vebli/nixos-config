{config, pkgs, pkgs-unstable, lib, fn, inputs, ... }:
{
    users.users.vebly = {
            isNormalUser = true;
            description = "vebly";
            extraGroups = [ "networkmanager" "wheel" "syncthing"];
            initialPassword = "123";
    };
    services.syncthing = {
        enable = true;
        systemService = true;
        package = pkgs-unstable.syncthing.overrideAttrs {
            version = "1.27.9";
        };
        settings = {
            devices = {
                "desktop" = {
                    name = "desktop";
                    id = "OFWTVXT-BMDHJVS-YLUXQPJ-34BFIXX-RW2FQZ4-4LCI3TF-FHJIZ5C-4IT5CAV";
                    autoAcceptFolders = true;
                };
                "thinkpad" = {
                    name = "thinkpad";
                    id = "R57OWQ4-ZCSYSQ7-EBIBLUU-U2ZBR4S-KE25GAB-S73M6KE-7EFIWBC-XTQY5AU";
                };
                "tablet" = {
                    name = "tablet";
                    id = "SSM3B6K-LYOAIUQ-BDHONJ3-2WCUJWR-GJFTYXA-R3GZVN2-5JB3WOV-PKOOTAZ";
                };
            };
            folders = {
                "SecondBrain" = { #Obsidian Vault
                    enable = true;
                    label = "SecondBrain";
                    path = "~/SecondBrain"; # Tilde is shortcut for /var/lib/syncthing
                    devices = [
                        "desktop"
                        "thinkpad"
                        "tablet"
                    ];
                }; 
            };
            # options = {
            #     relaysEnabled = false;
            # };
        };
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
                    youtube-dl
                    ytmdl
            ]);

            programs.git = {
                enable = true;
                userName = "vebly";
                userEmail = "";
            };

            home.sessionVariables = {
                EDITOR = "invim";
            };
# Let Home Manager install and manage itself.
            programs.home-manager.enable = true;
        };
    };
}
