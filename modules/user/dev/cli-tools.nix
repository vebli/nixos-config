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
        trashy
        usbutils

        tcpdump
        aircrack-ng
        wirelesstools

        nix-search-cli
    ];
    programs = {
        eza.enable = true;
        fzf.enable = true;
        zoxide.enable = true;
    };

}
