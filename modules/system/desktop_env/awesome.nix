{config, pkgs, pkgs-unstable, ...}:
{
    imports = [./display_server/xorg.nix];
    xdg.portal = {
        config = {
            "none+awesome" = {
                default = [
                    "gtk"
                ];
            };
        };
    };
    services.xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
                luadbi-mysql # Database abstraction layer
        ];
    };
}
