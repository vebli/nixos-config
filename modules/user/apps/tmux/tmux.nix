{config, pkgs, pkgs-unstable, ... }:
{
    programs = {
        tmux = {
            enable = true;
            baseIndex = 1;
            keyMode = "vi";
            prefix = "C-Space";
            shell = "${pkgs.zsh}/bin/zsh";
            tmuxinator.enable = true;
            plugins = with pkgs.tmuxPlugins; [
                cpu
                vim-tmux-navigator
                tmux-thumbs
                fzf-tmux-url

                {
                    plugin = continuum;
                    extraConfig = ''
                    set -g @continuum-restore 'on'
                    set -g @continuum-boot 'on'
                    set -g @continuum-save-interval '10'
                    '';
                }
             
                {
                    plugin = resurrect;
                    extraConfig = ''
                        set -g @resurrect-strategy-vim 'session' 
                        set -g @resurrect-strategy-nvim 'session' 
                        set -g @resurrect-capture-pane-contents 'on'
                        '';
                }
            ];
            extraConfig = ''
            '';
        };
    };
}
