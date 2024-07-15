{ config, pkgs, pkgs-unstable, inputs, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480

        ../../home/vebly
        ../../home/klee

        ../../modules/system/desktop_env/awesome.nix

        ../../modules/system/profiles/shared.nix
        ../../modules/system/profiles/gaming.nix

        ../../modules/system/hardware/grub.nix
        ../../modules/system/hardware/pipewire.nix

        ../../modules/system/network
        ];

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

    # Opengl
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
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

# Enable CUPS to print documents.
    services.printing.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.

    environment.systemPackages =  with pkgs; [
        awesome
        (catppuccin-sddm.override{
            flavor = "mocha";
        })
    ];



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
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

    system.stateVersion = "24.05"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}

