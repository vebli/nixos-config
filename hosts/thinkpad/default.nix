{ config, pkgs, pkgs-unstable, nixos-hardware, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ../../home/vebly
        ../../home/klee
        ../../modules/system/desktop_env/plasma.nix
        ../../modules/system/hardware/grub.nix
        ../../modules/system/hardware/pipewire.nix
        ];

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# networking.interfaces.enp0s3.useDHCP = true;

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_US.UTF-8";

    environment.sessionVariables = {
# If cursors become invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };
    hardware = {
        opengl.enable = true;
        nvidia.modesetting.enable = true; # Most wayland compositors need this 
    };

    xdg.portal.enable = true;
    services.xserver.enable = true;
    services.xserver.xkb = {
            layout = "us";
            variant = "";
    };

    services.xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
                luadbi-mysql # Database abstraction layer
        ];
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.

    environment.systemPackages =  with pkgs; [
        pkg-config
        awesome
        git
        wget
        acpi
        gtk3
        alacritty
        home-manager
    ];

    fonts.packages = with pkgs;[
        font-awesome
        siji
        nerdfonts
    ];
    users.defaultUserShell = pkgs.zsh;

    programs = {
        zsh = {
            enable = true;
            autosuggestions.enable = true;
            zsh-autoenv.enable = true;
            syntaxHighlighting.enable = true;
        };
        thunar.enable = true;
    };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
    services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

    system.stateVersion = "24.05"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}
