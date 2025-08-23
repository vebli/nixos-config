{config, pkgs, pkgs-unstable, lib, var, inputs, ... }:
{
  imports = [
    ./desktopCfg.nix
    ./syncthing.nix
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
      defaultSopsFile = ../../secrets/vebly.yaml;
      defaultSopsFormat= "yaml";
      age.keyFile = "/home/vebly/.config/sops/age/keys.txt";
      secrets = {
        "vpn/script".owner = "vebly";
        "syncthing/devices/desktop/id" = {owner = "vebly";};
        "syncthing/devices/desktop/addresses" = {owner = "vebly";};
        "syncthing/devices/thinkpad/id" = {owner = "vebly";};
        "syncthing/devices/thinkpad/addresses" = {owner = "vebly";};
        "syncthing/devices/tablet/id" = {owner = "vebly";};
        "syncthing/devices/tablet/addresses" = {owner = "vebly";};
        "syncthing/devices/server/id" = {owner = "vebly";};
        "syncthing/devices/server/addresses" = {owner = "vebly";};
        "syncthing/devices/phone/id" = {owner = "vebly";};
        "syncthing/devices/test" = {owner = "vebly";};
        "syncthing/folders/SecondBrain/devices" = {owner = "vebly";};
        "syncthing/folders/SecondBrain/path" = {owner = "vebly";};
        "syncthing/folders/FreeTube/devices" = {owner = "vebly";};
        "syncthing/folders/FreeTube/path" = {owner = "vebly";};
        "syncthing/folders/Studies/devices" = {owner = "vebly";};
        "syncthing/folders/Studies/path" = {owner = "vebly";};
        "syncthing/folders/Music/devices" = {owner = "vebly";};
        "syncthing/folders/Music/path" = {owner = "vebly";};
        "syncthing/folders/Books/devices" = {owner = "vebly";};
        "syncthing/folders/Books/path" = {owner = "vebly";};
      };
  };

  users.users.vebly = {
    isNormalUser = true;
    description = "vebly";
    extraGroups = [ "networkmanager" "wheel" "dialout" "syncthing" "libvirt" "libvirtd"];
    initialPassword = "123";
  };

  home-manager = {
    users.vebly = {
      imports = [
        ../../modules/user/sh/zsh/zsh.nix
        ../../modules/user/dev
      ];

      home.username = "vebly";
      home.homeDirectory = "/home/vebly";

      home.stateVersion = "24.05"; 

      programs.git = {
        enable = true;
        userName = "vebly";
        userEmail = "";
      };

      programs.ssh = {
        enable = true;
        extraConfig = ''
          Host github.com
              IdentityFile ~/.ssh/id_github

          Host expert.ethz.ch
              IdentityFile ~/.ssh/id_eth_code_expert

          Host gitlab.com 
            IdentityFile ~/.ssh/id_gitlab
        '';
          #
      };
      programs.taskwarrior = {
        enable = true;
        extraConfig = '''';
        package = pkgs.taskwarrior3;
      };
      
      home.packages = with pkgs;[ 
      (pkgs.writeShellScriptBin "vpn" /*bash*/ ''
       ${pkgs.openconnect.outPath + "/bin/openconnect"} $(cat ${config.sops.secrets."vpn/script".path})
       '')
        nvim-custom 
        tmux-custom
        tmuxinator
        taskwarrior-tui  
        timewarrior
        ffmpeg
        vit
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}
