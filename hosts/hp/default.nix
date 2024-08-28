{ config, pkgs, pkgs-unstable, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix

        ../../home/vebly
        ../../home/klee

        ../../modules/system/profiles/shared.nix

        ../../modules/system/desktop_env/plasma.nix

        ../../modules/system/hardware/grub.nix
        ../../modules/system/hardware/pipewire.nix

        ../../modules/system/network
        ];

    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.xkb = {
            layout = "us, ch";
            variant = "";
    };

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    services.printing.enable = true;

    environment.systemPackages =  with pkgs; [
        libreoffice
    ] ++ (with pkgs-unstable; [nvim-custom]);

    system.stateVersion = "24.05"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}
