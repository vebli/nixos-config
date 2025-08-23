{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++/ASM
        gcc
        glibc
        libgcc  

        gnumake
        cmake 
        libtool
        clang-tools_17
        nasm

        gdb
        gef
        pwndbg
        
        #Embedded
        arduino-cli
        platformio
        esptool


        # Javascript
        nodejs_22
        biome

        #DB
        sqlite

        python3
        virtualenv

        # Haskell
        ghc 

        # Other Languages
        lua
        rustup
        zig
        odin
        dart
        firebase-tools

    ];

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
