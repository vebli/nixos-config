{config, pkgs, var, ...}:
{
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
        git
        pavucontrol
        wget
        kitty
        gtk3
        cinnamon.nemo-with-extensions
        pkg-config
        acpi
        networkmanagerapplet
        home-manager
    ]);


    #ZSH
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
