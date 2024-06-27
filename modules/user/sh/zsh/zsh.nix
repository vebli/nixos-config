{ pkgs, lib, var, ... }:
{
    home.packages = with pkgs; [
        zsh
    ];
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            prezto.tmux.autoStartLocal = true;
            shellAliases = {
                "cpwd" = "pwd | tr -d \"\n\" | xargs echo -n | xclip -selection clipboard";
                "hrs" = "home-manager switch --flake ${var.path.root}";
                "ls" = "exa --icons";
            };
            initExtra = ''
                # eval "$(tmuxifier init -)"
                eval "$(zoxide init --cmd cd zsh)" #ZOXIDE alias
                PS1="%F{#00ffff}%n@ %~ %F{#00ffff}%f "
                '';
        };
        eza = {
            enable = true;
            enableZshIntegration = true;
        };

        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
