{config, pkgs, ...}:
{
    services.gvfs.enable = true; # Creates virtual file system necessary to access network stuff like samba shares. 
    services.avahi = { #Allows file manager to find shares
        enable = true;
        nssmdns = true;
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
