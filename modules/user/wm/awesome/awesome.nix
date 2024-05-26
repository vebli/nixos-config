{config, pkgs, pkgs-unstable, ...}:
{
    
    imports = [
        ../rofi/rofi.nix
    ];

    # services.xserver = {
    #     enable = true;
    #     displayManager = {
    #         sddm.enable = true;
    #     };
    #     windowManager.awesome = {
    #         enable = true;
    #         luaModules = with pkgs.luaPackages; [
    #             luarocks # is the package manager for Lua modules
    #                 luadbi-mysql # Database abstraction layer
    #         ];
    #
    #     };
    # };

    home.file."awesome" = {
        source = ./conf;
        target = ".config/awesome";
        recursive = true;
    };

    home.packrges = with pkgs; [
        nitrogen
        picom
        xclip
    ];
}
