{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  sops,
  ...
}: {
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
    ../../modules/system/profiles/virtualization.nix
  ];

  opt.vebly = {
    syncthing.enable = true;
    desktopCfg = {
      enable = true;
      sway.enable = false;
      awesome.enable = true;
    };
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;
    };
  };
  # programs.nix-ld = {
  #   enable = true;
  #   libraries= with pkgs; [
  #     glib
  #     gtk3
  #     zlib
  #     xorg.libX11
  #     xorg.libXrender
  #     libusb1
  #   ];
  # };

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
  hardware.graphics = {
    enable = true;
  };

  # Nvidia
  hardware.nvidia = {
    modesetting.enable = true; # Most wayland compositors need this
    prime = {
      offload = {
        # Only uses GPU when it thinks is needed to safe battery. Use sync.enable to always use GPU
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
  services.udev.packages = with pkgs; [platformio-core.udev stlink];

  environment.systemPackages =
    [
      pkgs.vscode
      pkgs.awesome
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
      })
    ]
    ++ (with pkgs-unstable; [
      copyq
      matlab #https://gitlab.com/doronbehar/nix-matlab
    ]);

  programs.fuse.userAllowOther = true;
  networking.firewall.allowedTCPPorts = [8000];

  system.stateVersion = "24.05";
}
