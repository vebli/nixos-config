{pkgs, ...}:
{
    services = {
        xserver = {
            enable = true;
            desktopManager.plasma5.enable = true;
        };
        displayManager = {
            sddm.enable = true;
            sddm.wayland.enable = true;
            defaultSession = "plasmawayland";
        };
    };
}
