{ config, pkgs, pkgs-unstable, inputs, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix

        ../../home/vebly

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

    services.udev.packages = with pkgs; [platformio-core.udev];

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
    services.xserver.videoDrivers = ["nvidia"];
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.

    environment.systemPackages =  with pkgs; [
        awesome
        (catppuccin-sddm.override{
            flavor = "mocha";
        })
    ] ++ (with pkgs-unstable; [
    ]);



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

}

