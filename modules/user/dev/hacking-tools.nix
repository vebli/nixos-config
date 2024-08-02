{config, pkgs, ...}:
{
    home.packages = with pkgs; [
        pwntools
        ghidra
        file
        ltrace
        strace
        nmap
        wireshark
    ];
}
