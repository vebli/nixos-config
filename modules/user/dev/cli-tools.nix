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

    # Hacking
        pwntools
        file
    ];
    programs = {
        eza.enable = true;
        fzf. enable = true;
        zoxide.enable = true;
    };

}
