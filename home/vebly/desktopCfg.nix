{config, pkgs, pkgs-unstable, lib, var, inputs, ...}:
let
  cfg = config.opt.vebly;
in
  {
  options.opt.vebly = {
    desktopCfg = lib.mkOption {
      default = true;
    };
  };
  config = lib.mkIf cfg.desktopCfg {
    home-manager = {
      users.vebly = {
        imports = [
          ../../modules/user/wm/awesome.nix 
          ../../modules/user/apps/latex.nix
          ../../modules/user/apps/librewolf.nix
          ../../modules/user/apps/kitty.nix
        ];
        home.packages = with pkgs; [


        ] ++ (with pkgs-unstable;[
            postman
            ngspice
            xournalpp
            signal-desktop
            discord
            arandr
            dbeaver-bin
            octaveFull
            sage
            digital
            obsidian
            ani-cli
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
