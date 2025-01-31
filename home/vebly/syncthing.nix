{config, pkgs, pkgs-unstable, lib, fn,...}: 
    let
	cfg = config.opt.vebly.syncthing;
    in
{
    options.opt.vebly.syncthing.enable = lib.mkEnableOption "Enable Syncthing"; 

    config = lib.mkIf cfg.enable {

        sops = {
            defaultSopsFile = ../../secrets/secrets.yaml;
            defaultSopsFormat= "yaml";
            age.keyFile = "/home/vebly/.config/sops/age/keys.txt";
            secrets = {
                "syncthing/devices/desktop/id" = {
                    owner = "vebly";
                };
                "syncthing/devices/desktop/addresses" = {
                    owner = "vebly";
                };
                "syncthing/devices/thinkpad/id" = {
                    owner = "vebly";
                };
                "syncthing/devices/thinkpad/addresses" = {
                    owner = "vebly";
                };
                "syncthing/devices/tablet/id" = {
                    owner = "vebly";
                };
                "syncthing/devices/tablet/addresses" = {
                    owner = "vebly";
                };
                "syncthing/devices/server/id" = {
                    owner = "vebly";
                };
                "syncthing/devices/server/addresses" = {
                    owner = "vebly";
                };
                "syncthing/devices/phone/id" = {
                    owner = "vebly";
                };
            };
        };

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
                        # id = "CTIMFRP-FHF54DM-2W6KLTQ-QAXL3Z2-3ZOZULV-7AVEKGK-2ZPAUCQ-PJWJMQX";
                        addresses = [
                            "tcp://192.168.1.171:22000"
                        ];
                    };
                    "thinkpad" = {
                        name = "thinkpad";
                        # id = "KN2XFMV-H6IDARR-SRTXGQU-TTDVC4Z-DARFWTN-NFZLLJ4-KUX66YP-PB4A2Q6";
                        addresses = [
                            "tcp://192.168.1.49:22000"
                        ];
                    };
                    "tablet" = {
                        name = "tablet";
                        id = "KKUXA3Y-Q3JFJLA-J5UFQ7W-HY6TSYG-YEKUL27-BM3JLCI-IOXBIUY-I4FLNA7";
                        addresses = [
                            "tcp://192.168.1.196:22000"
                        ];
                    };
                    "server" = {
                        name = "server";
                        id = "2YP7ZT6-ZIZQTUQ-AX3XSYI-R5X47W4-XDTOB6S-JZU7KEZ-YYSH4D2-3YMTEQJ";
                        addresses = [
                            "tcp://192.168.1.122:22000"
                            "tcp://vrpi-server.ddns.net:22000"
                        ];
                    };
                    "rpi-server" = {
                        name = "rpi-server";
                        id = "L6OJ7CQ-A4NXDX3-GLZIHL4-EB5UHIU-KNIITPF-DZOXNNV-PQAOBRP-HFTMKAH";
                        addresses = [
                            "vrpi-server.ddns.net:22000"
                        ];
                    };
                    "phone" = {
                        name = "phone";
                        id = "6YYFPNG-KQZ6VC6-QTRNCQP-QGKYDCR-XAZMGA2-6ALI2UU-MD2CSUV-BRMOEA7";
                    };
                } // fn.syncthingGenId ["desktop" "thinkpad"];
                folders = {
                    "SecondBrain" = { 
                        enable = true;
                        label = "SecondBrain";
                        path = "~/SecondBrain";
                        copyOwndershipFromParent = true;
                        devices = [
                            "desktop"
                                "thinkpad"
                                "tablet"
                                "server"
                                "rpi-server"
                        ];
                    }; 
                    "FreeTube" = { 
                        enable = true;
                        label = "FreeTube";
                        path = "~/.config/FreeTube";
                        copyOwndershipFromParent = true;
                        devices = [
                            "desktop"
                            "thinkpad"
                            "server"
                            "rpi-server"
                        ];
                    }; 
                    "Music" = {
                        enable = true;
                        label = "Music";
                        path = "~/Sync/Music";
                        copyOwndershipFromParent = true;
                        devices = [
                            "phone"
                            "thinkpad"
                            "tablet"
                        ];
                    };
                    "Books" = {
                        enable = true;
                        label = "Books";
                        path = "~/Sync/Books";
                        copyOwndershipFromParent = true;
                        devices = [
                            "phone"
                            "thinkpad"
                            "tablet"
                        ];
                    };
                    "Studies" = {
                        enable = true;
                        label = "Studies";
                        path = "~/Sync/Studies";
                        copyOwndershipFromParent = true;
                        devices = [
                            "thinkpad"
                            "tablet"
                        ];
                    };
                };
                options = {
                    relaysEnabled = false;
                };
            };
        };
    };
}
