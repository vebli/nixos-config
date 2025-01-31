{
    description = "Global dev shells";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
    };
    outputs = inputs @ {self, nixpkgs, ...}: 
    let
      system = "x86_64-linux"; # Change this to your system architecture
      pkgs = nixpkgs.legacyPackages.${system};
    in 
    {
        devShells."${system}" = {
            "python" = pkgs.mkShell{
                packages = with pkgs.python312Packages; [
                # Math
                    numpy
                    scipy
                    matplotlib
                # Data
                    pandas
                # Networking
                    requests
                    flask
                    beautifulsoup4
                ]; 
            };
            "cpp" = {};
            "c" = {};
        };
    };
}
