{config, pkgs, pkgs-unstable, ...}:
{
  home.packages = with pkgs; [
    git
    wget
    sops
    killall
    gnupg
    unzip
    tree
    ripgrep
    usbutils
    direnv

    clang-manpages
    man-pages
    man-pages-posix
    linux-manual
    tmux.man

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
