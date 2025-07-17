{pkgs, ...}:
{
    imports = [ ./display_server/wayland.nix];
    services = {
        desktopManager.plasma6.enable = true;
    };
}
