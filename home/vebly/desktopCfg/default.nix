{config, pkgs, pkgs-unstable, lib, ...}:
let
  cfg = config.opt.vebly.desktopCfg;
in
  {
  options.opt.vebly.desktopCfg = {
      enable = lib.mkEnableOption "Enable desktop applications";
      awesome.enable = lib.mkEnableOption "Enable awesome window manager config";
      sway.enable = lib.mkEnableOption "Enable awesome window manager config";
      emacs.enable = lib.mkEnableOption "Enable emacs config";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      users.vebly = {
        imports = [
            ./kitty.nix
        ]
        ++ lib.optional cfg.awesome.enable ./awesome.nix
        ++ lib.optional cfg.sway.enable ./sway
        ++ lib.optional cfg.emacs.enable ./emacs.nix;

        home.packages = with pkgs; [
            texlab
            texliveFull

            kicad
            ngspice
            qucs-s
            digital
            octaveFull

            sage
                
            dbeaver-bin
            ghidra
            postman

            xournalpp
            rembg

            masterpdfeditor
            libreoffice
            discord

        ] ++ (with pkgs-unstable;[
            obsidian
            tor-browser
            freetube
            ytmdl
            ytdownloader
          ]);

        programs.librewolf = {
            enable = true;
            languagePacks = ["en-GB" "de"];
            profiles.vebly = {
                isDefault = true;
                handlers = {
                    force = true;
                    mimeTypes = {
                        "application/pdf" = {
                            action = 3;
                            ask = false;
                        };
                    };
                };
                search = {
                    force = true;
                    default = "ddg";
                };
            };
        };

        home.file.".config/matlab/nix.sh".text = "INSTALL_DIR=$HOME/Imperative/Matlab/installation";

      };
    };
  };
}
