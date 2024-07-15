# ==========================================
    # Hardware specific optimisations: 
# ==========================================
    # services.xserver.videoDrivers = ["nvidia"];
    # hardware.nvidia = {
    #     modesetting.enable = true; # Most wayland compositors need this 
    #     prime = {
    #
    #         offload = { # Only uses GPU when it thinks is needed to safe battery. Use sync.enable to always use GPU
    #             enable = true;
    #             enableOffloadCmd = true;
    #         };
    #         nvidiaBusId = "PCI:01:00:0";
    #         intelBusId = "PCI:02:00:0";
    #     };
    # };

{config, pkgs, ...}:
{
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;

    environment.systemPackages = with pkgs; [
        lutris # Game launcher
        protonup #For better performance
        mangohud #To monitor FPS, TEMP, etc. add 'mangohud %command%' to launch options
    ];
    programs.gamemode.enable = true; # Add 'gamemoderun %command%' to launch options for better performance
}
