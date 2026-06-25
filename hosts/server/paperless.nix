{config, pkgs, ...}:
let 
    WEB_PORT = 28981;
in
{
    services.paperless = {
        enable = true;
        dataDir = "/mnt/sdb/services/paperless";
        address = "0.0.0.0";
        port =  WEB_PORT; 
    };
    networking.firewall.allowedTCPPorts = [ WEB_PORT ];
}
