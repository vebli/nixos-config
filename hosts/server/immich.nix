{config, pkgs, pkgs-unstable, ...}:
{
    environment.systemPackages = [ pkgs-unstable.immich-cli ];
    services.immich = {
        enable = true;
        package = pkgs-unstable.immich;
        mediaLocation = "/mnt/sdb/services/immich";
        openFirewall = true;
        host = "0.0.0.0";
    };
}
