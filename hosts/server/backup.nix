{config, pkgs, ...}:
{
    sops = {
        defaultSopsFile = ../../secrets/vebly/backup.yaml;
        secrets = {
            "cloud/password" = { owner = "vebly";};
            "cloud/url" = { owner = "vebly";};
            "cloud/username" = { owner = "vebly";};
            "cloud/encryption_password" = { owner = "vebly";};
        };
    };

    sops.templates."rcloneConfigFile".content = ''
        [cloud]
        type = webdav
        url = ${config.sops.placeholder."cloud/url"}
        vendor = nextcloud
        user = ${config.sops.placeholder."cloud/username"}
        pass = ${config.sops.placeholder."cloud/password"}
    '';

    services.restic.backups = let
            paths = ["/home/vebly/SecondBrain"];
            initialize = true;
            pruneOpts = [
                "--keep-daily 7"
                "--keep-weekly 5"
                "--keep-monthly 5"
                "--keep-yearly 10"
            ];
            timerConfig = {
                OnCalendar = "18:00";
                Persistent = true;
            };
            passwordFile = config.sops.secrets."cloud/encryption_password".path;
    in
    {
        cloud = {
            inherit paths initialize pruneOpts timerConfig passwordFile;
            rcloneConfigFile = config.sops.templates."rcloneConfigFile".path;
            repository = "rclone:cloud:backup";
        };
        local = {
            inherit paths initialize pruneOpts timerConfig passwordFile;
            repository = "/mnt/sdb/backup";
        };

    };
}
