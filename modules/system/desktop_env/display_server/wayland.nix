{config, pkgs, pkgs-unstable, ...}:
{
    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1"; # If cursors become invisible
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT= "wayland";
    };
}
