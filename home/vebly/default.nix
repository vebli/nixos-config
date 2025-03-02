{config, pkgs, pkgs-unstable, lib, var, inputs, ... }:
{
  imports = [
    ./desktopCfg.nix
    ./syncthing.nix
    ../../modules/scripts/activation/syncthing_update_devices.nix
  ];
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
        nvim-custom 
        tmux-custom
        tmuxinator
        taskwarrior-tui  
        timewarrior
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
