{config, pkgs, ...}:

{
    programs.hyprland = {
        xwayland.enable = true;
        enable = true;
        enableNvidiaPatches = true;
    };
    environment.systemPackages = with pkgs; [
        waybar 
        libnotify
        dunst
        swww
        wofi
        rofi-wayland #like dmenu
        wl-clipboard
        pavucontrol
        mpc-cli
    ];
}
