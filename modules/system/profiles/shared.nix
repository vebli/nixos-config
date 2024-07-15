{config, pkgs, pkgs-unstable, ...}:
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

    environment.systemPackages =  with pkgs; [
        git
        wget
        kitty
        gtk3
        cinnamon.nemo-with-extensions
        pkg-config
        acpi
        home-manager
    ];



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
