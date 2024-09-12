{config, pkgs, pkgs-unstable, ...}: 
{
    services.syncthing = {
        enable = true;
        user = "vebly";
        dataDir = "/home/vebly";
        configDir = "/home/vebly/.config/syncthing";
        systemService = true;
        openDefaultPorts = true; #TCP/UDP 22000 for transfer
        overrideDevices = true;
        overrideFolders = true;
        package = pkgs-unstable.syncthing.overrideAttrs {
            version = "1.27.9";
        };
        settings = {
            devices = {
                "desktop" = {
                    name = "desktop";
                    id = "CTIMFRP-FHF54DM-2W6KLTQ-QAXL3Z2-3ZOZULV-7AVEKGK-2ZPAUCQ-PJWJMQX";
                    addresses = [
                        "tcp://192.168.1.171:22000"
                    ];
                };
                "thinkpad" = {
                    name = "thinkpad";
                    id = "KN2XFMV-H6IDARR-SRTXGQU-TTDVC4Z-DARFWTN-NFZLLJ4-KUX66YP-PB4A2Q6";
                    addresses = [
                        "tcp://192.168.1.196:22000"
                    ];
                };
                "tablet" = {
                    name = "tablet";
                    id = "KKUXA3Y-Q3JFJLA-J5UFQ7W-HY6TSYG-YEKUL27-BM3JLCI-IOXBIUY-I4FLNA7";
                    addresses = [
                        "tcp://192.168.1.49:22000"
                    ];
                };
                "server" = {
                    name = "server";
                    id = "L6OJ7CQ-A4NXDX3-GLZIHL4-EB5UHIU-KNIITPF-DZOXNNV-PQAOBRP-HFTMKAH";
                    addresses = [
                        "vrpi-server.ddns.net:22000"
                    ];
                };
            };
            folders = {
                "SecondBrain" = { #Obsidian Vault
                    enable = true;
                    label = "SecondBrain";
                    path = "~/SecondBrain";
                    copyOwndershipFromParent = true;
                    devices = [
                        "desktop"
                        "thinkpad"
                        "tablet"
                        "server"
                    ];
                }; 
                "FreeTube" = { #Obsidian Vault
                    enable = true;
                    label = "FreeTube";
                    path = "~/.config/FreeTube";
                    copyOwndershipFromParent = true;
                    devices = [
                        "desktop"
                        "thinkpad"
                        "server"
                    ];
                }; 
            };
            options = {
                relaysEnabled = false;
            };
        };
    };
}
