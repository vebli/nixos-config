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
        nasm

        gef
        pwndbg

        # Javascript
        nodejs_22
        biome
        
        #Embedded
        arduino-cli
        platformio
        esptool
        stlink-tool
        openocd
        stlink


        #DB
        sqlite

        python3
        virtualenv


        # Other Languages
        clojure
        ghc 
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
