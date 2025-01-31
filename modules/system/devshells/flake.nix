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
                packages = with pkgs.python312Packages; with pkgs; [
                    python3Full
                ] ++[
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
                shellHook = ''
                    export PS1="\[\033[1;32m\]\w (python) 󱔎\[\033[0m\]  "
                    '';
            };
            "cpp" = pkgs.mkShell{
                packages = with pkgs; [
                    gcc
                    cmake
                    gnumake
                    # General Purpose
                    boost
                    # Networking
                    asio
                    # Testing
                    gtest
                    #Math 
                    eigen
                    #Graphics
                    sfml
                    libGLU
                    glfw
                    glfw-wayland
                ];
                shellHook = ''
                    export PS1="\[\033[1;34m\]\w (cpp) \[\033[0m\]  "
                '';
            };
            "c" = pkgs.mkShell {
                packages = with pkgs; [
                    gcc
                    cmake
                    gnumake
                    glibc
                ];
                shellHook = ''
                    export PS1="\[\033[1;34m\]\w (c) \[\033[0m\]  "
                '';
            };
        };
    };
}
