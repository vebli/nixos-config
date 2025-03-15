{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi
  ];

  # https://github.com/davatorium/rofi/blob/next/CONFIG.md
  home.file."rofi" = {
    target = ".config/rofi/config.rasi";
    text = ''
      @theme "Arc-Dark"

      configuration {
        font: "Iosevka Nerd Font Medium 12";
        //show-icons: true;

        timeout {
          delay: 10;
          action: "kb-cancel";
        }
      }

    '';
  };
}
