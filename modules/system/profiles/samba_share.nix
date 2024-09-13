{config, pkgs, ...}:
{
    services.avahi.enable = true;
    services.samba = {
       enable = true;
       securityType = "user";
       openFirewall = true;
       shares {
            private = {
                path = "/dev/sdb1/public";
                browsable = "yes";
                comment = "NAS Storage"
            }
       }
       wsdd = {
           enable = true;
           openFireWall = true;
       };
    };
}
