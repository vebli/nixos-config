# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:
{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Bootloader.
    boot.loader.grub = {
        enable = true; 
        efiSupport = true;
        devices = ["nodev"];
        useOSProber = true;
        theme = /boot/grub/themes/minegrub-world-selection;
    };
    boot.loader.efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
    };

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# networking.interfaces.enp0s3.useDHCP = true;

# Enable networking
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

# Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.vebly = {
        isNormalUser = true;
        description = "vebly";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            firefox
#  thunderbird
        ];
    };

    environment.systemPackages =  
        (with pkgs; [
        awesome
# HYPRLAND
         waybar 
         libnotify
         dunst
         swww
         wofi
         rofi-wayland #like dmenu
         wl-clipboard
         pavucontrol
         mpc-cli
# X 
         nitrogen
         picom
         dmenu
# LSPS 
         biome
         cmake-language-server
         nodePackages_latest.typescript-language-server
         tailwindcss-language-server
         nodePackages_latest.vls
         lua-language-server
         rnix-lsp
         nodePackages_latest.volar
         sqls
         texlab

# Terminal Tools
         wget
         git
         zoxide
         fzf
         unzip
         cmake
         python3
         libgcc
         gcc
         nodejs_21
         neofetch
         vim	
         killall
         clang-tools_9
         sqlite
# Desktop applications
         zathura
         librewolf
         alacritty
         gtk3
         texliveTeTeX
         texliveFull
# gnome3.gnome-control-center
# gnome3.gnome-tweaks
# gnome3.gnome-shell-extensions
#Fonts
         font-awesome
         ])

         ++

         (with pkgs-unstable; [
          neovim
          dbeaver
          tmux 
# obsidian
         ]);

    users.defaultUserShell = pkgs.zsh;

    programs = {
        hyprland = {
            enable = true;
            enableNvidiaPatches = true;
            xwayland.enable = true;
        };
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

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
        nix.settings.experimental-features = ["nix-command" "flakes"];

}
