{config, pkgs, pkgs-unstable, ...}:
{
    services.xserver.enable = true;
    xdg.portal = {
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        enable = true;
    };
}
