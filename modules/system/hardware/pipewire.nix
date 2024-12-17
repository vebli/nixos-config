{conig, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        alsa-utils  # Hardware Protocol
    ];
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        jack.enable = true;
    };

}
