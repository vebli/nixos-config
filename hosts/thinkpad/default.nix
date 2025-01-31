{ config, pkgs, pkgs-unstable, inputs, sops,  ... }: {
    imports = [ 
        ./hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480

        ../../home/vebly

        ../../modules/system/desktop_env/awesome.nix

        ../../modules/system/profiles/shared.nix
        ../../modules/system/profiles/gaming.nix

        ../../modules/system/hardware/grub.nix
        ../../modules/system/hardware/pipewire.nix

        ../../modules/system/network
        ];

        sops.secrets."vpn/script" = { owner = "vebly";};

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# networking.interfaces.enp0s3.useDHCP = true;

    services.displayManager = {
            sddm = {
                enable = true;
                theme = "catppuccin-mocha";
                package = pkgs.kdePackages.sddm;
            };
            defaultSession = "none+awesome";
    };


    services.xserver.xkb = {
            layout = "us";
            variant = "";
    };

    i18n.defaultLocale = "en_US.UTF-8";

    opt.vebly.syncthing.enable = true;


    # Opengl
    hardware.graphics = {
        enable = true;
    };

    # Nvidia 
    hardware.nvidia = {
        modesetting.enable = true; # Most wayland compositors need this 
        prime = {
            offload = { # Only uses GPU when it thinks is needed to safe battery. Use sync.enable to always use GPU
                enable = true;
                enableOffloadCmd = true;
            };
            nvidiaBusId = "PCI:01:00:0";
            intelBusId = "PCI:02:00:0";
        };
    };

    hardware.opentabletdriver = {
        enable = true;
        package = pkgs-unstable.opentabletdriver;
        daemon.enable = true;
    };
# Enable CUPS to print documents.
    services.printing = {
        enable = true;
        drivers = with pkgs; [cnijfilter2];
    };
    services.udev.packages = with pkgs; [platformio-core.udev];

    environment.systemPackages = [
        (pkgs.writeShellScriptBin "vpn" /*bash*/ ''
            ${pkgs.openconnect.outPath + "/bin/openconnect"} $(cat ${config.sops.secrets."vpn/script".path})
        '')
        pkgs.openconnect # for vpn
        pkgs.awesome
        pkgs.xournalpp
        pkgs.signal-desktop
        (pkgs.catppuccin-sddm.override{
            flavor = "mocha";
        })
    ] ++ (with pkgs-unstable; [nvim-custom]);



# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
    # services.openssh.enable = true;

# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [ 8000 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

    system.stateVersion = "24.05"; 

}

