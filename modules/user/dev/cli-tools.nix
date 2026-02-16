{config, pkgs, pkgs-unstable, ...}:
{
  home.packages = with pkgs; [
    git
    wget
    sops
    killall
    unzip
    tree
    ripgrep
    patchelf
    usbutils
    direnv
    nix-direnv

    (dmenu-custom.override {
        patches = {
            CENTER_PATCH.enable = true;
            FUZZYMATCH_PATCH.enable = true;
            PASSWORD_PATCH.enable = true;
            LINE_HEIGHT_PATCH.enable = true;
            MULTI_SELECTION_PATCH.enable = true;
        };
    })

    clang-manpages
    man-pages
    man-pages-posix
    linux-manual
    tmux.man
    binutils.man

    jq
    tcpdump
    aircrack-ng
    wirelesstools
    strace
    pwntools
    file
    ltrace
    strace
    nmap
    wireshark

    android-studio-tools

    nix-search-cli
  ];
  programs = {
    eza.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
  };

}
