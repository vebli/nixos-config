{ config, pkgs, pkgs-unstable, inputs, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix

        ../../home/vebly
        ../../home/vebly/syncthing.nix

        ../../modules/system/profiles/shared.nix

        ../../modules/system/hardware/grub.nix
        ../../modules/system/network

        ];
    opt.vebly.desktopCfg= false;

    services.xserver.xkb = {
            layout = "us";
            variant = "";
    };

    services.openssh.enable = true;

    services.kmscon = {
        enable = true;
        fonts = [{name = "FiraCode Nerd Font"; package = pkgs.nerdfonts;}];
    };

    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "server";
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
        8384 #Syncthing gui
        ]; 
    };

    fileSystems = {
        "/mnt/sdb".device = "/dev/sdb1";
    };
 
    services.avahi.openFirewall = true;
    users.groups.smbgroup = {}; 
    users.users = {
        klee = {
            isNormalUser = true;   
            group = "smbgroup";
            initialPassword = "123";
        };
        vebly.extraGroups = ["smbgroup"];
        smbuser = {
            isNormalUser = true;
            group = "smbgroup";
            initialPassword = "123";
        };
    };

    services.samba = {
       enable = true;
       package = pkgs.sambaFull;
       enableNmbd = true;
       enableWinbindd = true;
       securityType = "user";
       openFirewall = true;
       nsswins = true;
       extraConfig = ''
       hosts allow = 192.168.0.0/16
       hosts deny = 0.0.0.0/0
       netbios name = NAS


       [Media]
       path = /mnt/sdb/public/media
       valid users = klee vebly
       force user = smbuser
       force group = smbgroup
       force create mode = 0664
       directory mask = 0775
       force directory mode = 0775
       browsable = yes
       read only = no
       writable = yes

       [Honigklee]
       path = /mnt/sdb/private/honigklee
       valid users = klee vebly
       force user = smbuser
       force group = smbgroup
       create mask = 0664
       force create mode = 0664
       directory mask = 0775
       force directory mode = 0775
       writable = yes

       [Vebly]
       path = /mnt/sdb/private/vebly
       valid users = vebly
       force user = smbuser
       force group = smbgroup
       create mask = 0664
       force create mode = 0664
       directory mask = 0775
       force directory mode = 0775
       writable = yes
       '';
    };

    services.samba-wsdd = {
        enable = true;
        openFirewall = true;
        hostname = "NAS";
        discovery = true;
    };

    networking.wlanInterfaces."wlan-monitor" = {
        device = "wlp2s0";
        type = "monitor";
    };

    environment.systemPackages =  with pkgs; [
    ] ++ (with pkgs-unstable; [nvim-custom]);



# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    services.syncthing.guiAddress = "0.0.0.0:8384";

    system.stateVersion = "24.05"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}

