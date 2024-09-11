{ pkgs, lib, var, ... }:
let 
    dracula_green = "#8aff80";
    dracula_yellow = "#F1FA8C";
    dracula_blue = "#8BE9FD";
    dracula_orange = "#FFB86C";
    dracula_pink = "#FF79C6";
    dracula_purple = "#BD93F9";
    dracula_red = "#FF5555";

    command_color = "fg=${dracula_green}";
    error_color = "fg=${dracula_red}";
    string_color = "fg=${dracula_yellow}"; 
    globbing_color = "fg=${dracula_blue}"; 
    precommand_color = "fg=${dracula_orange}";
    substitution_color = "fg=${dracula_pink}"; 
in
{
    home.packages = with pkgs; [
        zsh
    ];
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting = {
                enable = true;
                styles = {
                    # Options: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
                    builtin = command_color;
                    command = command_color;
                    precommand = precommand_color; 
                    function = command_color;
                    path = command_color;

                    alias = command_color;
                    suffix-alias = command_color;
                    global-alias = command_color;

                    unknown-token = error_color;  
                    globbing = globbing_color;
                    reserved-word = string_color; 

                    double-quoted-argument = string_color;
                    single-quoted-argument = string_color;

                    command-substitution-delimiter = substitution_color;

                    single-hyphen-option = substitution_color;
                    double-hyphen-option = substitution_color;

                };
            };
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
                PS1="%F{${dracula_purple}}%n@ %~ %F{${dracula_purple}}%f "

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
