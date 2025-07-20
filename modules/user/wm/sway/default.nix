{config, pkgs, pkgs-unstable, inputs, ...}:
{
    imports = [../rofi];
    wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        xwayland = true;
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
    home.file."i3blocks" = {
          source = ./i3blocks;
          target = ".config/i3blocks";
          recursive = true;
      };

    home.packages = with pkgs; [
        nemo-with-extensions
        pavucontrol
        grim 
        slurp
        wl-clipboard
        wl-color-picker
        mako
        swaybg
        i3status i3blocks sysstat jq
        rofi-wayland
    ];
}
