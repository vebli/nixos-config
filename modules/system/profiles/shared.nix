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

    programs.nix-ld = {
        enable = true;
        # libraries = with pkgs
    };
    
    time.timeZone = "Europe/Zurich";

    fonts.packages = with pkgs;[
        font-awesome
        siji
        jetbrains-mono
        iosevka
        icomoon-feather
        cantarell-fonts
        inter
        terminus_font

        nerd-fonts.fira-code
        nerd-fonts.iosevka
    ];

    environment.systemPackages =  [
    ] ++ (with pkgs; [
        # Essentials
        git
        home-manager
        wget
        kitty
        pkg-config
        appimage-run
        htop-vim
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
    man.cache.enable = true;
  };

}
