{config, pkgs, ...}:
{
    boot.binfmt.emulatedSystems = [ "riscv64-linux" ];
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
}
