{ pkgs, lib, ... }:
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
                "hrs" = "home-manager switch --flake /home/vebly/nixos-config";
                "ls" = "exa --icons";
            };
            initExtra = ''
                # eval "$(tmuxifier init -)"
                eval "$(zoxide init --cmd cd zsh)" #ZOXIDE alias
                PS1="%F{#00ffff}%n@ %~ %F{#00ffff}%f "
                '';
        };
        eza.enableZshIntegration = true;
        fzf.enableZshIntegration = true;
        zoxide.enableZshIntegration = true;
    };
}
