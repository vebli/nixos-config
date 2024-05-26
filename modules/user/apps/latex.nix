{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        texlab
        texliveFull
        # texliveTeTeX
        zathura
    ];
}
