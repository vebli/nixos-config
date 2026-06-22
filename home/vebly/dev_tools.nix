{config, pkgs, pkgs-unstable, inputs, ...}:
{
    home.packages = with pkgs; [
        # C/C++/ASM
        glibc
        gcc
        libgcc  
        gdb 
        gef
        gnumake
        cmake 
        libtool
        nasm

        
        #Embedded
        arduino-cli
        platformio
        esptool
        stlink-tool
        openocd
        stlink

        sqlite
        nodejs
        biome

        python3
        virtualenv

        clojure
        babashka
        ghc 
        lua
        rustup
        zig
        odin
        flutter
        firebase-tools
        android-studio-tools

        tree
        patchelf
        usbutils
        direnv
        nix-direnv

        # man-pages
        clang-manpages
        man-pages
        man-pages-posix
        linux-manual
        tmux.man
        binutils.man

        jq
        tcpdump
        aircrack-ng
        wirelesstools
        strace
        pwntools
        file
        ltrace
        strace
        nmap
        wireshark

    ] ++ (with pkgs-unstable; [
        # gcc-arm-embedded
    ]);

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
    programs = {
        eza.enable = true;
        fzf.enable = true;
        zoxide.enable = true;
    };
}
