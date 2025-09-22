{config, pkgs, pkgs-unstable, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++/ASM
        glibc
        gcc
        libgcc  
        gdb 

        gnumake
        cmake 
        libtool
        clang-tools_17
        nasm

        gef
        pwndbg
        
        #Embedded
        arduino-cli
        platformio
        esptool
        stlink-tool
        openocd
        stlink

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
        flutter
        firebase-tools
    ] ++ (with pkgs-unstable; [
        # gcc-arm-embedded
    ]);

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
