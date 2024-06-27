{pkgs, ...}:
{
    services = {
        desktopManager.plasma6.enable = true;
        displayManager = {
            sddm.enable = true;
            sddm.wayland.enable = true;
            defaultSession = "none+awesome";
        };
    };
}
