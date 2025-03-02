{config, pkgs, var, ...}:
{
    imports = [
        ../devshells
    ];

    nix= {
        extraOptions = ''
            experimental-features = nix-command flakes pipe-operators
        '';
        settings.experimental-features = ["nix-command" "flakes" "pipe-operators"]; 
    };
        

    
    time.timeZone = "Europe/Zurich";
    fonts.packages = with pkgs;[
        font-awesome
        siji
        nerdfonts
        jetbrains-mono
        iosevka
        icomoon-feather
        cantarell-fonts
        inter
    ];

    environment.systemPackages =  [
        (import ../../scripts/hellow.nix {inherit pkgs;})
        (import ../../scripts/wallpaper/random-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.path.wallpapers;})
        (import ../../scripts/wallpaper/current-wallpaper.nix {pkgs=pkgs; wallpaperPath=var.path.wallpapers;})
    ] ++ (with pkgs; [
        # Essentials
        git
        home-manager
        wget
        kitty
        pkg-config
        gtk3
        appimage-run
        
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
  documentation = {
    man.enable = true;
    dev.enable = true;
    doc.enable = true;
    man.generateCaches = true;
  };

}
