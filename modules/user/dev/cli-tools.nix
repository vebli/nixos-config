{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        git
        wget
        killall
        gnupg
        unzip
        tmux
        tmuxifier
        tree
        nix-index
        ripgrep
    ];
    programs = {
        eza.enable = true;
        fzf. enable = true;
        zoxide.enable = true;
    };

}
