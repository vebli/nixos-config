{pkgs, config, ...}:
{
   imports = [
        ./langs.nix
        ./cli-tools.nix
        ./emacs.nix
   ];
}
