{config, pkgs, ...}:
{
    home.packages = with pkgs; [
        matlab
    ];

    home.file."matlab" = {
        text = ''INSTALL_DIR=$HOME/Downloads/Software/matlab/installation'';
        target = ".config/matlab/nix.sh";
    };
}
