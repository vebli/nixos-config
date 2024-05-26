{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        # C/C++
        libgcc  
        cmake 
        gcc
        clang-tools_17
        cmake-language-server

        # Javascript
        nodejs_21
        via
        biome
        nodePackages_latest.typescript-language-server
        tailwindcss-language-server
        nodePackages_latest.vls
        nodePackages_latest.volar

        #Databases
        sqlite
        sqls

        #Nix
        rnix-lsp

        #Rust
        rustup

        #python
        python3

        #Lua
        lua-language-server

    ];


}
