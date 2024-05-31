{config, pkgs, pkgs-unstable, ... }:
{
    programs.neovim = 
        let 
            toLua = str: "lua << EOF\n${str}\nEOF\n;";
            toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n;";
        in
        {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraLuaConfig = ''
        vim.cmd.colorscheme("dracula")
        vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloats", {bg = "none" })
        ${builtins.readFile ./conf/lua/core/keymaps.lua}
        ${builtins.readFile ./conf/lua/core/init.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/lsp.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/lualine.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/comment.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/treesitter.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/surround.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/vimtex.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/highlight-colors.lua}
        ${builtins.readFile ./conf/lua/core/plugin_config/autopairs.lua}
        '';

        plugins = with pkgs.vimPlugins; [

        telescope-nvim
        telescope-fzf-native-nvim
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp_luasnip
        nvim-dap

        luasnip 
        friendly-snippets

        lualine-nvim
        oil-nvim
        nvim-highlight-colors

        {
            plugin = indent-blankline-nvim;
            config = toLua "require(\"ibl\").setup()";
        }

        oxocarbon-nvim
        dracula-nvim

        comment-nvim
        vim-surround
        vimtex 
        ];

        extraPackages = with pkgs; [
            xclip
            wl-clipboard

            clang-tools_17
            cmake-language-server
            sqls
            rnix-lsp
            lua-language-server
            biome
            tailwindcss-language-server
            nodePackages_latest.typescript-language-server
            nodePackages_latest.vls
            docker-compose-language-service
            arduino-language-server
            python311Packages.python-lsp-server
            vscode-extensions.rust-lang.rust-analyzer
        ];

    };
}
