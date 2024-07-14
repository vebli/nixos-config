{pkgs, config, ...}:
{
   imports = [
        ./langs.nix
        ./hacking-tools.nix
        ./lsp.nix
        ./cli-tools.nix
   ];
}
