{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  fn,
  var,
  ...
}: let
  cfg = config.opt.vebly.syncthing;
in {
  options.opt.vebly.syncthing.enable = lib.mkEnableOption "Enable Syncthing";

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "vebly";
      dataDir = "/home/vebly";
      configDir = "/home/vebly/.config/syncthing";
      systemService = true;
      openDefaultPorts = true; #TCP/UDP 22000 for transfer
      overrideDevices = false;
      overrideFolders = true;
      package = pkgs-unstable.syncthing.overrideAttrs {
        version = "1.27.9";
      };
    };
  };
}
