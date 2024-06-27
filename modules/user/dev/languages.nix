{config, pkgs, pkgs-unstable, ...}:
{
    home.packages = with pkgs; [
        # C/C++
        libgcc  
        gnumake
        cmake 
        gcc
        clang-tools_17
        gdb
        cmake-language-server
        #Arduino
        arduino-language-server

        # Javascript
        nodejs_22
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
        nil

        #Rust
        rustup
        vscode-extensions.rust-lang.rust-analyzer

        #python
        python3

        #Lua
        lua
        lua-language-server

    ];
    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = "set disassembly-flavor intel";
    };

}
