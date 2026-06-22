{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  var,
  inputs,
  ...
}: {
  imports = [
    ./desktopCfg
    ./syncthing.nix
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/home/vebly/.config/sops/age/keys.txt";
    defaultSopsFormat = "yaml";
    secrets = {
      "vpn/param" = {
        owner = "vebly";
        sopsFile = ../../secrets/vebly/vpn.yaml;
      };
      "ssh/config" = {
        owner = "vebly";
        sopsFile = ../../secrets/vebly/ssh.yaml;
      };
    };
  };

  users.users.vebly = {
    isNormalUser = true;
    description = "vebly";
    extraGroups = ["networkmanager" "wheel" "dialout" "syncthing" "libvirt" "libvirtd"];
    initialPassword = "123";
  };

  home-manager = {
    users.vebly = {
      imports = [
          ./zsh.nix
          ./dev_tools.nix
      ];

      home.username = "vebly";
      home.homeDirectory = "/home/vebly";

      home.stateVersion = "24.05";

      programs.git = {
        enable = true;
        settings = {
            user.name = "vebly";
            user.email = "";
        };
      };

      programs.ssh = {
        enable = true;
        extraConfig = ''
            Include ${config.sops.secrets."ssh/config".path}
        '';
      };

      home.packages = with pkgs; [
        git
        sops
        wget
        ripgrep
        killall
        unzip
        nix-search-cli
        nvim-custom
        tmux-custom
        tmuxinator

        (dmenu-custom.override {
            patches = {
                CENTER_PATCH.enable = true;
                FUZZYMATCH_PATCH.enable = true;
                PASSWORD_PATCH.enable = true;
                LINE_HEIGHT_PATCH.enable = true;
                MULTI_SELECTION_PATCH.enable = true;
            };
        })

        (pkgs.writeShellScriptBin "vpn"
          /* bash */
          ''
            ${pkgs.openconnect.outPath + "/bin/openconnect"} $(cat ${config.sops.secrets."vpn/param".path})
          '')
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}
