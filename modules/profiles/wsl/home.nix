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

# want to update the value, then make sure to first check the Home Manager release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

        home.packages = with pkgs-unstable; [
        # kitty
        
        ];

    home.sessionVariables = {
        EDITOR = "nvim";
    };
    # home.file = {
    #     "zshrc" = {
    #         source = ./zshrc;
    #         target = "./.zshrc";
    #         recursive = true;
    #     };
    #     "nvim" = {
    #         source = ./nvim;
    #         target = ".config/nvim";
    #         recursive = true;
    #     };
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
    #     "awesome" = {
    #         source = /home/vebly/.dotfiles/awesomeWM;
    #         target = ".config/awesome";
    #         recursive = true;
    #     };
    #     "tmux" = {
    #         source = /home/vebly/.dotfiles/tmux.conf;
    #         target = ".tmux.conf";
    #         recursive = true;
    #     };
    #     "tmux-package-manager" = {
    #         source = /home/vebly/.dotfiles/tmux;
    #         target = ".tmux";
    #         recursive = true;
    #     };
    #     "polybar" = {
    #         source = /home/vebly/.dotfiles/polybar;
    #         target = ".config/polybar";
    #         recursive = true;
    #     };
    #     "kitty" = {
    #         source = /home/vebly/.dotfiles/kitty;
    #         target = ".config/kitty";
    #         recursive = true;
    #     };
    #     "rofi" = {
    #         source = /home/vebly/.dotfiles/rofi;
    #         target = ".config/rofi";
    #         recursive = true;
    #     };
    # };
    #
# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
