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
                "gdb" = "gdb -q";
                "ndwl" = "nmcli device wifi list";
                "ncs" = "nmcli connection show";
            };
            initExtra = ''
                # eval "$(tmuxifier init -)"
                eval "$(zoxide init --cmd cd zsh)" #ZOXIDE alias
                PS1="%F{#00ffff}%n@ %~ %F{#00ffff}%f "

                up() {
                    if [[ $# -ne 1 ]] || ! [[ $1 =~ ^[0-9]+$ ]]; then
                        echo "Invalid argument"
                        return 1
                    fi

                    local current_depth=$(pwd | grep -o "/" | wc -l)

                    if [[ $1 -ge $current_depth ]]; then
                        # If so, go to the root directory
                        cd /
                    else
                        # Otherwise, go up the specified number of directories
                        for ((i=0; i<$1; i++)); do
                            cd ..
                        done
                    fi
                }
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
