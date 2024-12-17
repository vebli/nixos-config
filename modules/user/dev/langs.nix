{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++
        libgcc  
        gnumake
        cmake 
        gcc
        clang-tools_17
        nasm

        gdb
        gef
        pwndbg
        
        #Embedded
        arduino-cli
        platformio

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

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
