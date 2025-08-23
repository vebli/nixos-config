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
  script_name = "syncthing_update_devices";
  script = pkgs.stdenv.mkDerivation {
    name = "Syncthing Post Rebuild";
    src = ./.;
    buildInputs = with pkgs.python3Packages; [requests lxml pyinstaller];
    installPhase = /*bash*/ ''
    mkdir -p $out/bin;
    cp $src/${script_name}.py $out
    pyinstaller --onefile $out/${script_name}.py --distpath $out/bin/
    rm $out/${script_name}.py
    '';
  };
in {
  options.opt.vebly.syncthing.enable = lib.mkEnableOption "Enable Syncthing";

  config = lib.mkIf cfg.enable {

    system.activationScripts.updateSyncthingDevices.text = ''
    echo "Updating Syncthing device IDs..."
    .${script}/bin/${script_name}
    '';

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
