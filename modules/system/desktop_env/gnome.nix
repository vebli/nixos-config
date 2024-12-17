{pkgs, ...}:
{
    services = {
        xserver = {
            enable = true;
            displayManager = {
                gdm = {
                    enable = true;
                    wayland = true;
                };
            };
            desktopManager.gnome.enable = true;
        };
    };

    environment.systemPackages = with pkgs;[
        gnome3.gnome-control-center
        gnome3.gnome-tweaks
        gnome3.gnome-shell-extensions
    ];
}
