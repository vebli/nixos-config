{config, pkgs, pkgs-unstable, inputs, ...}:
{
    imports = [../rofi];
    wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        extraOptions = [
            "--unsupported-gpu"
        ];
        config = {
            bars = [];
            menu = "";
            keybindings = {};
            terminal = "";
        };
        extraConfig = builtins.readFile ./config;
    };
    home.packages = with pkgs; [
        grim 
        slurp
        wl-clipboard
        wl-color-picker
        mako
        swaybg
        i3status
        rofi-wayland
    ];
}
