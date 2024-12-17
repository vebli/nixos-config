{config, pkgs, var, ...}:
{
    nix.settings.experimental-features = ["nix-command" "flakes"]; 
    time.timeZone = "Europe/Zurich";
    fonts.packages = with pkgs;[
        font-awesome
        siji
        nerdfonts
        jetbrains-mono
        iosevka
        icomoon-feather
    ];

    environment.systemPackages =  [
        (import ../../scripts/hellow.nix {inherit pkgs;})
        (import ../../scripts/wallpaper/random-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.wallpaperPath;})
        (import ../../scripts/wallpaper/current-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.wallpaperPath;})
    ] ++ (with pkgs; [
        # Essentials
        git
        home-manager
        wget
        kitty
        pkg-config
        gtk3
        
        # Default Apps/Tools 
        shutter
        pavucontrol
        nemo-with-extensions
        acpi
        networkmanagerapplet
        mpv
        okular
        zathura
        libreoffice
    ]);


    users.defaultUserShell = pkgs.zsh;
    programs = {
        zsh = {
            enable = true;
            autosuggestions.enable = true;
            zsh-autoenv.enable = true;
            syntaxHighlighting.enable = true;
        };
    };
}
