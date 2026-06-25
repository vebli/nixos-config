{config, pkgs, pkgs-unstable, lib, var, ...}:
let
  cfg = config.opt.vebly.desktopCfg;
in
  {
  options.opt.vebly.desktopCfg = {
      enable = lib.mkEnableOption "Enable desktop applications";
      wm.awesome.enable = lib.mkEnableOption "Enable awesome window manager config";
      wm.sway.enable = lib.mkEnableOption "Enable awesome window manager config";
      emacs.enable = lib.mkEnableOption "Enable emacs config";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      users.vebly = {
        imports = [
            ./kitty.nix
        ]
        ++ lib.optional cfg.wm.awesome.enable ./awesome.nix
        ++ lib.optional cfg.wm.sway.enable ./sway
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
            gimp

            masterpdfeditor
            libreoffice
            discord

            (dmenu-custom.override {
                 patches = {
                     CENTER_PATCH.enable = true;
                     FUZZYMATCH_PATCH.enable = true;
                     PASSWORD_PATCH.enable = true;
                     LINE_HEIGHT_PATCH.enable = true;
                     MULTI_SELECTION_PATCH.enable = true;
                     }; 
                 }
             )
            (import ../../../modules/scripts/toggle_kb_lang.nix {inherit pkgs;})
            (import ../../../modules/scripts/wallpaper/random-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.path.wallpapers;})
            (import ../../../modules/scripts/wallpaper/current-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.path.wallpapers;})

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
