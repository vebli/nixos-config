{pkgs, ...}: let 
  file_name = "syncthing_update_devices";
  script = pkgs.stdenv.mkDerivation {
    name = "Syncthing Post Rebuild";
    src = ./.;
    buildInputs = with pkgs.python3Packages; [requests lxml pyinstaller];
    installPhase = /*bash*/ ''
    mkdir -p $out/bin;
    cp $src/${file_name}.py $out
    pyinstaller --onefile $out/${file_name}.py --distpath $out/bin/
    rm $out/${file_name}.py
    '';
  };
in {
    system.activationScripts.updateSyncthingDevices.text = ''
    echo "Updating Syncthing device IDs..."
    .${script}/bin/${file_name}
    '';
}
 
