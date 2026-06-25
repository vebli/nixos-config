{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../home/vebly

    # ../../modules/system/desktop_env/plasma.nix
    # ../../modules/system/desktop_env/sway.nix

    ../../modules/system/desktop_env/awesome.nix

    ../../modules/system/profiles/shared.nix
    ../../modules/system/profiles/gaming.nix
    ../../modules/system/profiles/virtualization.nix

    ../../modules/system/hardware/grub.nix
    ../../modules/system/hardware/pipewire.nix

    ../../modules/system/network
  ];

  users.groups.users.gid = 100; # used for mounting file system

  opt.vebly = {
      syncthing.enable = true;
      desktopCfg = {
          enable = true;
          sway.enable = false;
          wm.awesome.enable = true;
      };
  };
  services.udev.packages = with pkgs; [platformio-core.udev stlink];

  hardware.i2c.enable = true;
  users.users.vebly.extraGroups = ["i2c"];
  
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 6000000;
  };

  services.desktopManager.plasma6.enable = true;

  services.xserver.displayManager.lightdm = {
      enable = true;
      greeters.gtk.enable = true;
  };
  services.displayManager.defaultSession = "none+awesome";
  # services.displayManager = {
    # sddm = {
    #   enable = true;
    #   wayland.enable = true;
    # };
    # # defaultSession = "sway";
    # defaultSession = "none+awesome";
  # };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.pcscd.enable = true;
  programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # AI
  services.ollama = {
    enable = true;
  };
  services.open-webui = {
    enable = true;
  };

  # If it doesn't work: 'sudo rmmod wacom hid_uclogic'
  hardware.opentabletdriver = {
    enable = true;
    package = pkgs-unstable.opentabletdriver;
    daemon.enable = true;
  };
  # GPU
  services.xserver.videoDrivers = ["nvidia"];
  # services.xserver.videoDrivers = ["nouveau"];
  hardware.graphics.enable = true; #Enable Opengl
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.systemPackages = with pkgs;
    [
      brave
      gimp
      freecad
      davinci-resolve
    ]
    ++ (with pkgs-unstable; [
            losslesscut
      ]);

  system.stateVersion = "24.05";
}
