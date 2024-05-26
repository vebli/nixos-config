{ pkgs, ... }:
{
    home.packages = with pkgs; [
        zsh
    ];

    # programs.zsh = {
    #     enable = true;
    #     enableCompletion = true;
    #     autosuggestions.enable = true;
    #     syntaxHighlighting.enable = true;
    #
    #     shellAliases = {
    #         ll = "ls -l";
    #         update = "sudo nixos-rebuild switch";
    #     };
    #     histSize = 10000;
    #     histFile = "${config.xdg.dataHome}/zsh/history";
    # };

    home.file = {
        "zshrc" = {
            source = ./zshrc;
            target = "./.zshrc";
        };
    };
}
