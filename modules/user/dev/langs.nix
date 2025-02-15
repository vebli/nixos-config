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

        #zig
        zig
        #odin 
        odin
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
