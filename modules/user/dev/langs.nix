{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++/ASM
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
        esptool


        # Javascript
        nodejs_22
        biome

        #DB
        sqlite

        python3
        virtualenv

        # Other Languages
        lua
        rustup
        zig
        odin

        # Haskell
        ghc 
    ];

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
