{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        git
        wget
        killall
        gnupg
        unzip
        tree
        nix-index
        ripgrep
        trashy
        usbutils

        tcpdump
        aircrack-ng
        wirelesstools
    ];
    programs = {
        eza.enable = true;
        fzf.enable = true;
        zoxide.enable = true;
    };

}
