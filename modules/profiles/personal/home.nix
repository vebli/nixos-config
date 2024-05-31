{config, pkgs, pkgs-unstable, lib, ... }:

{
    home.username = "vebly";
    home.homeDirectory = "/home/vebly";

    imports = [
        ../../user/apps/nvim/nvim.nix 
        ../../user/apps/tmux/tmux.nix 
        ../../user/apps/kitty.nix 
        ../../user/sh/zsh/zsh.nix
        ../../user/apps/latex.nix 
        ../../user/dev/cli-tools.nix 
        ../../user/dev/languages.nix 
        ../../user/wm/awesome/awesome.nix 
        ../../user/wm/awesome/awesome.nix 
    ];

    home.stateVersion = "23.11"; 

    home.packages = with pkgs; [
        librewolf
        obsidian
        dbeaver
        octaveFull
        emacs
        emacs-all-the-icons-fonts
        emacsPackages.fontawesome
        emacsPackages.unicode-fonts
    ];

    programs.git = {
        enable = true;
        userName = "vebly";
        userEmail = "";
    };


    home.sessionVariables = {
        EDITOR = "nvim";
    };
    #     "alacritty" = {
    #         source = ./alacritty;
    #         target = ".config/alacritty";
    #         recursive = true;
    #     };
    #     "hypr" = {
    #         source = ./hypr;
    #         target = ".config/hypr";
    #         recursive = true;
    #     };
    #     "polybar" = {
    #         source = /home/vebly/.dotfiles/polybar;
    #         target = ".config/polybar";
    #         recursive = true;
    #     };
    # };
    #
# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
