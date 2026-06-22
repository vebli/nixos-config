{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    themeFile = "rose-pine";
    font = {
      name = "FiraCode Nerd Font";
      size = 14.0;
    };
    keybindings = {
      "kitty_mod" = "no_op";
    };
    settings = {
      # background_opacity = lib.mkForce "0.8";
      enable_audio_bell = false;
      confirm_os_window_close = "0";
      url_color = "#0087bd";
      url_style = "curly";
    };
  };
}
