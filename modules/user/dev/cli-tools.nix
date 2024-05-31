{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        git
        wget
        killall
        gnupg
        fzf
        zoxide
        unzip
        tmux
        tmuxifier
    ];
}
