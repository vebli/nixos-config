{config, pkgs, lib, ...}:
{
    environment.systemPackages = with pkgs; [lxqt.lxqt-policykit]; #Needed by gvfs (Usually comes with desktop environments)
    networking.networkmanager.enable = true;
    services.gvfs = {
        enable = true; # Creates virtual file system necessary to access network stuff like samba shares. 
        package = lib.mkForce pkgs.gnome3.gvfs;
    };
    services.avahi = { #Allows file manager to find shares
        enable = true;
        nssmdns4 = true; 
        publish = {
            enable = true;
            addresses = true;
            domain = true;
            hinfo = true;
            userServices = true;
            workstation = true;
        };
    };
}
