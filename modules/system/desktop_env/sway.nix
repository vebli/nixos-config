{config, pkgs, ...}:{
    imports = [
    ./display_server/wayland.nix
    ];
    programs.xwayland.enable = true;

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs;[
            libsForQt5.xdg-desktop-portal-kde
        ];
    };
    security.polkit.enable = true;
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraSessionCommands = /*bash*/''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export _JAVA_AWT_WM_NONREPARENTING=1
          export MOZ_ENABLE_WAYLAND=1
        '';
        extraOptions = [
            "--unsupported-gpu"
        ];
    };
}
