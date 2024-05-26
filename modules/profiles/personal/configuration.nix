{ config, pkgs, pkgs-unstable, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix
        ../../system/hardware/grub.nix
        ../../system/hardware/pipewire.nix
        ];

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# networking.interfaces.enp0s3.useDHCP = true;

# Enable networkingconfiguration
    networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "Europe/Zurich";

# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    environment.sessionVariables = {
# If cursors become invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };
    hardware = {
# Opengl
        opengl.enable = true;
# Most wayland compositors need this 
        nvidia.modesetting.enable = true;
    };
# Desktop Portals
    xdg.portal.enable = true;

    services = {
        xserver = {
            enable = true;
            displayManager = {
            # gdm = {
            #     enable = true;
            #     wayland = true;
            # };
                sddm.enable = true;
                sddm.wayland.enable = true;
                defaultSession = "plasmawayland";
            };
            windowManager.awesome = {
                enable = true;
                luaModules = with pkgs.luaPackages; [
                    luarocks # is the package manager for Lua modules
                    luadbi-mysql # Database abstraction layer
                ];

            };
            desktopManager.plasma5.enable = true;
            layout = "us";
            xkbVariant = "";
# Enable Gnome 
            # desktopManager.gnome.enable = true;
        };
    };

# Enable CUPS to print documents.
    services.printing.enable = true;


# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.vebly = {
        isNormalUser = true;
        description = "vebly";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages =  
        (with pkgs; [
        awesome
        git
        wget
# Desktop applications
         librewolf
         alacritty
         gtk3
         acpi
         octaveFull
# gnome3.gnome-control-center
# gnome3.gnome-tweaks
# gnome3.gnome-shell-extensions
#Fonts
         font-awesome
         siji
         nerdfonts
         ])

         ++

         (with pkgs-unstable; [
         emacs
         emacs-all-the-icons-fonts
         emacsPackages.fontawesome
         emacsPackages.unicode-fonts
         neovim
         dbeaver-bin
         tmux 
         tmuxifier
         obsidian
         ]);

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

    system.stateVersion = "23.11"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}
