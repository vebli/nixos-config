{pkgs, ...}: {
  # https://github.com/davatorium/rofi/blob/next/CONFIG.md
  home.file."rofi-config" = {
    target = ".config/rofi/";
    source = ./config;
    recursive = true;
  };
}
