{pkgs, lib, config, ... }:
{
    options = {
        xorg.enable = lib.mkEnableOption "enable xorg";
        wayland.enable = lib.mkEnableOption "enable wayland";
    };

    config = lib.mkMerge [
        (lib.mkIf config.xorg.enable{
            services.xserver = {
                enable = true;
                layout = "us";
                xkbVariant = "";
            };
        })

        (lib.mkIf config.wayland.enable{
            services.wayland = {
               enable = true; 
            };
        })
    ];

    services.xserver.displayManager.lightdm.enable = true;
}
