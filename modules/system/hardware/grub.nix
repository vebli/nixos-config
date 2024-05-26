{pkgs, ...}:

{
    boot.loader.grub = {
        enable = true; 
        efiSupport = true;
        devices = ["nodev"];
        useOSProber = true;
        theme = /boot/grub/themes/minegrub-world-selection;
    };
    boot.loader.efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
    };
}
