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
	
    opt.vebly.syncthing.enable= false;
    opt.vebly.desktopCfg.enable= false;

    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.kernelPackages = pkgs.linuxPackages_6_1;

    i18n.defaultLocale = "en_US.UTF-8";

    services.displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
        };
    };

    services.xserver.xkb = {
            layout = "us, ch";
            variant = "";
    };
    hardware.graphics.enable = true;

    services.printing = {
        enable = true;
        drivers = with pkgs; [cnijfilter2];
    };

    environment.systemPackages = with pkgs;[
        atlauncher
        vim
        wl-clipboard
    ] ++ (with pkgs-unstable; []);

    system.stateVersion = "24.05"; 

}
