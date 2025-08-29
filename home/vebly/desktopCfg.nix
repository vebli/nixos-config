{config, pkgs, pkgs-unstable, lib, var, inputs, ...}:
let
  cfg = config.opt.vebly.desktopCfg;
in
  {
  options.opt.vebly.desktopCfg = {
      enable = lib.mkEnableOption "Enable desktop applications";
      awesome.enable = lib.mkEnableOption "Enable awesome window manager config";
      sway.enable = lib.mkEnableOption "Enable awesome window manager config";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      users.vebly = {
        imports = [
          ../../modules/user/apps/latex.nix
          ../../modules/user/apps/librewolf.nix
          ../../modules/user/apps/kitty.nix
        ]
        ++ lib.optional cfg.awesome.enable ../../modules/user/wm/awesome.nix
        ++ lib.optional cfg.sway.enable ../../modules/user/wm/sway;

        home.packages = with pkgs; [


        ] ++ (with pkgs-unstable;[
            postman
            ngspice
            xournalpp
            signal-desktop
            discord
            arandr
            dbeaver-bin
            ghidra
            octaveFull
            sage
            digital
            obsidian
            ani-cli
            tor-browser-bundle-bin
            mangal
            freetube
            ytmdl
            ytdownloader
            kicad
            qucs-s
          ]);

        home.file={
          "wallpapers" = {
            source = inputs.wallpapers.outPath;
            target = lib.strings.removePrefix "~/" var.path.wallpapers; 
            recursive = true;
          };
        };
        home.file.".config/matlab/nix.sh".text = "INSTALL_DIR=$HOME/Imperative/Matlab/installation";
          xdg.mimeApps = {
            enable = true;
            defaultApplications = {
              "application/pdf" = "okularApplication_pdf.desktop";
            };
          };
      };
    };
  };
}
