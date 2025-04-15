{
  description = "Global dev shells";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    esp-dev = {
      url = "github:mirrexagon/nixpkgs-esp-dev";
      flake = false;
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux"; # Change this to your system architecture
    pkgs = import nixpkgs {
      inherit system;
      overlays = [(import "${inputs.esp-dev}/overlay.nix")];
    };
    colors = {
        red = ''\[\033[1;31m\]'';
        light-blue = ''\[\033[1;34m\]'';
        light-gren = ''\[\033[1;32m\]'';
    };
    mkPrompt = str: color: ''
    export PS1="${color}\w ${str} \[\033[0m\] "
    '';
          
  in {
    devShells."${system}" = {
      "python" = pkgs.mkShell {
        packages = with pkgs;
          [
            python3Full
          ]
          ++ (with pkgs.python312Packages; [
            alembic
            # Math
            numpy
            scipy
            matplotlib

            # Data
            sqlalchemy
            pandas
            pydantic

            # Networking
            fastapi
            uvicorn
            requests
            flask
            beautifulsoup4
          ]);
        shellHook = '' ${mkPrompt "(python) 󱔎 " colors.light-gren } '';
      };
      "cpp" = pkgs.mkShell {
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
          glew

          glfw
          glfw3
          glfw-wayland
        ];
        shellHook = ''
            ${mkPrompt "(cpp)" colors.light-blue}
        '';
      };
      "c" = pkgs.mkShell {
        packages = with pkgs; [
          gcc
          cmake
          gnumake
          glibc

          libGLU
          glew
          glfw
          glfw3
          glfw-wayland
        ];
        shellHook = ''
            ${mkPrompt "(c)" colors.light-blue}
        '';
      };
      "esp-idf" = pkgs.mkShell {
        packages = with pkgs; [esp-idf-full esptool];
        shellHook= ''
            ${mkPrompt "(esp-idf-full)  " colors.light-blue}
        '';
      };
    };
  };
}
