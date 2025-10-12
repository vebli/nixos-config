{ config, pkgs, pkgs-unstable, inputs, ... }:
{
    services.samba = {
        enable = true;
        package = pkgs.sambaFull;
        nmbd.enable = true;
        winbindd.enable = true;
        openFirewall = true;
        nsswins = true;
        settings = let 
            recycle = {
                "vfs object" = "recycle";
                "recycle:repository" = ".recycle";
                "recycle:keeptree" = "yes";
                "recycle:versions" = "yes";
                "recycle:maxsize" = "0";
                "recycle:exclude" = "*.tmp";
                "recycle:touch" = "no";
                "recycle:touch_mtime" = "no";
            };
        in
        {
            global = {
                "hosts allow" = "192.168.0.0/16";
                "netbios name" = "NAS";
                security = "user";
            };

            Vebly = {
                "path" = "/mnt/sdb/private/vebly";
                "valid users" = "vebly";
                "force user" = "smbuser";
                "force group" = "smbgroup";
                "create mask" = "0664";
                "force create mode" = "0664";
                "directory mask" = "0775";
                "force directory mode" = "0775";
                "writable" = "yes";
            }//recycle;

            Media = {
                "path" = "/mnt/sdb/public/media";
                "valid users" = "klee vebly";
                "force user" = "smbuser";
                "force group" = "smbgroup";
                "force create mode" = "0664";
                "directory mask" = "0775";
                "force directory mode" = "0775";
                "browsable" = "yes";
                "read only" = "no";
                "writable" = "yes";
            }//recycle;

            Honigklee = {
                "path" = "/mnt/sdb/private/honigklee";
                "valid users" = "klee vebly";
                "force user" = "smbuser";
                "force group" = "smbgroup";
                "create mask" = "0664";
                "force create mode" = "0664";
                "directory mask" = "0775";
                "force directory mode" = "0775";
                "writable" = "yes";
            }//recycle;
        };
    };
    services.avahi.openFirewall = true;
    users.groups.smbgroup = {}; 
    users.users = {
        klee = {
            isNormalUser = true;   
            group = "smbgroup";
            initialPassword = "123";
        };
        vebly = {
            extraGroups = ["smbgroup"];
        };
        smbuser = {
            isNormalUser = true;
            group = "smbgroup";
            initialPassword = "123";
        };
    };


    services.samba-wsdd = {
        enable = true;
        openFirewall = true;
        hostname = "NAS";
        discovery = true;
    };
}
