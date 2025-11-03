{ config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./backup.nix
      ./samba.nix
      ./paperless.nix
      ./immich.nix

      ../../home/vebly

      ../../modules/system/profiles/shared.nix

      ../../modules/system/hardware/grub.nix
      ../../modules/system/network

    ];
  opt.vebly.desktopCfg.enable = false;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
        PasswordAuthentication = false;
    };
  };

    services.kmscon = {
      enable = true;
      fonts = [{name = "FiraCode Nerd Font"; package = pkgs.nerdfonts;}];
    };

  i18n.defaultLocale = "en_US.UTF-8";

  security.auditd = {enable = true;};

  networking.hostName = "server";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8384 #Syncthing gui
      631 # CUPS gui
    ]; 
  };

  fileSystems = {
    "/mnt/sdb".device = "/dev/sdb1";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  opt.vebly.syncthing.enable = true;
  services.syncthing.guiAddress = "0.0.0.0:8384";


  system.stateVersion = "24.05"; 
  nix.settings.experimental-features = ["nix-command" "flakes"]; 

}


