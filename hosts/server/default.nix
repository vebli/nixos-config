{ config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./samba.nix

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

  # networking.wlanInterfaces."wlan-monitor" = {
  #   device = "wlp0s20u3u2";
  #   type = "monitor";
  # };

  # services.printing = {
    # enable = true;
    # defaultShared = true;
    # browsing = true;
    # drivers = with pkgs;[canon-cups-ufr2 canon-capt];
    # listenAddresses = [ "0.0.0.0:631"];
    # allowFrom = ["all"];
  # };

  # environment.systemPackages =  with pkgs; [
  # ] ++ (with pkgs-unstable; []);



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  opt.vebly.syncthing.enable = true;
  services.syncthing.guiAddress = "0.0.0.0:8384";

  system.stateVersion = "24.05"; 
  nix.settings.experimental-features = ["nix-command" "flakes"]; 

}


