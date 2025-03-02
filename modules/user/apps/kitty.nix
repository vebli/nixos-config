{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    theme = "Rosé Pine";
    font = {
      name = "FiraCode Nerd Font";
      size = 14.0;
    };
    keybindings = {
      "kitty_mod" = "no_op";
      "ctrl+plus" = "change_font_size all + 2.0";
      "ctrl+minus" = "change_font_size all - 2.0";
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
