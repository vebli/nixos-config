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

    opt.vebly.syncthing.enable = true;
    services.udev.packages = with pkgs; [platformio-core.udev];

    boot.kernel.sysctl = {
        "fs.inotify.max_user_watches"= 6000000;
    };
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

  # AI
  services.ollama ={
    enable = true;
    acceleration = "cuda";
  };
  services.open-webui = {
    enable = true;
  };

    # GPU
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics.enable = true; #Enable Opengl
    hardware.nvidia = {
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    environment.systemPackages =  with pkgs; [
        xterm
        awesome
        cudaPackages.cudatoolkit
        (catppuccin-sddm.override{
            flavor = "mocha";
        })
    ] ++ (with pkgs-unstable; [
    ]);

    system.stateVersion = "24.05"; 
}

