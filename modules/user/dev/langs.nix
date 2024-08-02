{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++
        libgcc  
        gnumake
        cmake 
        gcc
        clang-tools_17
        gdb

        # Javascript
        nodejs_22
        biome

        #Databases
        sqlite

        #Rust
        rustup

        #python
        python3
        virtualenv

        #Lua
        lua
    ];

    home.file."gdb-peda" = {
        source = inputs.gdb-peda.outPath;
        target = ".config/peda";
        recursive = true;
    };

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
        set disassembly-flavor intel
        source  ~/.config/peda/peda.py
        '';
    };
}
