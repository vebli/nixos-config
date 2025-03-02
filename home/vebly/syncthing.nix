{config, pkgs, pkgs-unstable, lib, fn, var,...}: 
let
  cfg = config.opt.vebly.syncthing;
in
  {


  options.opt.vebly.syncthing.enable = lib.mkEnableOption "Enable Syncthing"; 


  config = lib.mkIf cfg.enable {

    sops = {
      secrets = {
        "syncthing/devices/desktop/id" = { owner = "vebly"; };
        "syncthing/devices/desktop/addresses" = { owner = "vebly"; };
        "syncthing/devices/thinkpad/id" = { owner = "vebly"; };
        "syncthing/devices/thinkpad/addresses" = { owner = "vebly"; };
        "syncthing/devices/tablet/id" = { owner = "vebly"; };
        "syncthing/devices/tablet/addresses" = { owner = "vebly"; };
        "syncthing/devices/server/id" = { owner = "vebly"; };
        "syncthing/devices/server/addresses" = { owner = "vebly"; };
        "syncthing/devices/phone/id" = { owner = "vebly"; };
      };
    };

    services.syncthing = {
      enable = true;
      user = "vebly";
      dataDir = "/home/vebly";
      configDir = "/home/vebly/.config/syncthing";
      systemService = true;
      openDefaultPorts = true; #TCP/UDP 22000 for transfer
      overrideDevices = true;
      overrideFolders = true;
      package = pkgs-unstable.syncthing.overrideAttrs {
        version = "1.27.9";
      };
      settings = {
        devices = {
          "desktop" = {
            name = "desktop";
            addresses = [
              "tcp://192.168.1.171:22000"
            ];
          };
          "thinkpad" = {
            name = "thinkpad";
            addresses = [
              "tcp://192.168.1.49:22000"
            ];
          };
          "tablet" = {
            name = "tablet";
            addresses = [
              "tcp://192.168.1.196:22000"
            ];
          };
          "server" = {
            name = "server";
            addresses = [
              "tcp://192.168.1.122:22000"
              "tcp://vrpi-server.ddns.net:22000"
            ];
          };
          "rpi-server" = {
            name = "rpi-server";
            addresses = [
              "vrpi-server.ddns.net:22000"
            ];
          };
          "phone" = {
            name = "phone";
          };
        } // fn.syncthingGenId ["desktop" "thinkpad" "tablet" "server" "rpi-server" "phone"];
        folders = {
          "SecondBrain" = { 
            enable = true;
            label = "SecondBrain";
            path = "~/SecondBrain";
            copyOwndershipFromParent = true;
            devices = [
              "desktop"
              "thinkpad"
              "tablet"
              "server"
              "rpi-server"
            ];
          }; 
          "FreeTube" = { 
            enable = true;
            label = "FreeTube";
            path = "~/.config/FreeTube";
            copyOwndershipFromParent = true;
            devices = [
              "desktop"
              "thinkpad"
              "server"
              "rpi-server"
            ];
          }; 
          "Music" = {
            enable = true;
            label = "Music";
            path = "~/Sync/Music";
            copyOwndershipFromParent = true;
            devices = [
              "phone"
              "thinkpad"
              "tablet"
            ];
          };
          "Books" = {
            enable = true;
            label = "Books";
            path = "~/Sync/Books";
            copyOwndershipFromParent = true;
            devices = [
              "phone"
              "thinkpad"
              "tablet"
            ];
          };
          "Studies" = {
            enable = true;
            label = "Studies";
            path = "~/Sync/Studies";
            copyOwndershipFromParent = true;
            devices = [
              "thinkpad"
              "tablet"
            ];
          };
        };
        options = {
          relaysEnabled = false;
        };
      };
    };
  };
}
