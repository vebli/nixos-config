{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        emacs
        # C/C++
        libgcc  
        gnumake
        cmake 
        gcc
        libtool
        clang-tools_17
        nasm

        gdb
        gef
        pwndbg
        
        #Embedded
        arduino-cli
        platformio
        ngspice

        #zig
        zig
        #odin 
        odin
        # Javascript
        nodejs_22
        biome
        postman

        #Databases
        sqlite

        #Rust
        rustup

        #python
        python3
        virtualenv

        #Lua
        lua

        #LSPS
        emacsPackages.elsa
        asm-lsp
        cmake-language-server
        arduino-language-server
        vscode-extensions.vue.volar
        tailwindcss-language-server
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        sqls
        nil
        nixd
        vscode-extensions.rust-lang.rust-analyzer
        lua-language-server
        python312Packages.python-lsp-server
        ols
        alejandra
        vscode-extensions.vue.volar
    ];

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
