{pkgs, inputs, ... }:
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
                vim-tmux-navigator
                tmux-thumbs
                fzf-tmux-url
                { 
                    plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; 
                    extraConfig = ''
                        set -g @minimal-tmux-status "top"
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
                {
                    plugin = continuum;
                    extraConfig = ''
                        set -g @continuum-restore 'on'
                        set -g @continuum-boot 'on'
                        set -g @continuum-save-interval '10'
                        set -g @continuum-boot-options 'kitty'
                    '';
                }
            ];
            extraConfig = ''
            '';
        };
    };
}
