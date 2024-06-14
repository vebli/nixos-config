{config, pkgs, pkgs-unstable, ... }:
{
    programs.neovim = 
    let 
        toLua = str: "lua << EOF\n${str}\nEOF\n;";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n;";
        treesitter-parsers = with pkgs.vimPlugins.nvim-treesitter-parsers;[
            c cpp go zig rust python nix php lua
            vue javascript typescript css html
            json yaml toml
            latex bibtex
        ];
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
             ${builtins.readFile ./lua/init.lua}
             ${builtins.readFile ./lua/keymaps.lua}
             ${builtins.readFile ./lua/lsp.lua}
         '';
        
         plugins = with pkgs.vimPlugins; [
        
             {
                 plugin = auto-pairs;
                 config = toLuaFile ./lua/autopairs.lua;
             }
             {
                 plugin = nvim-comment;
                 config = toLua "require(\"Comment\").setup()";
             }
             {
                 plugin = vim-surround;
                 config = toLua "require(\"nvim-surround\").setup()";
             }
             {
                 plugin =  telescope-nvim;
                 config = toLuaFile ./lua/telescope.lua;
             }
             {
                 plugin = telescope-fzf-native-nvim;
                 config = toLua "require(\"telescope\").load_extension(\"fzf\")";
             }
             {
                 plugin = nvim-treesitter;
                 config = toLuaFile ./lua/treesitter.lua;
             }
             {
                 plugin = nvim-treesitter-textobjects;
                 config = toLuaFile ./lua/treesitter-textobjects.lua;
             }
        
             oxocarbon-nvim
             dracula-nvim
             nvim-lspconfig
             nvim-cmp
             cmp-nvim-lsp
        
             cmp_luasnip
             luasnip 
             friendly-snippets
             trouble-nvim
        
             {
                 plugin = lualine-nvim;
                 config = toLuaFile ./lua/lualine.lua; 
             }
             {
                 plugin = nvim-highlight-colors;
                 config = toLuaFile ./lua/highlight-colors.lua;
        
             }
             {
                 plugin = oil-nvim;
                 config = toLua "require(\"oil\").setup()";
             }
             {
                 plugin = indent-blankline-nvim;
                 config = toLua "require(\"ibl\").setup()";
             }
        
             {
                 plugin = vimtex;
                 config = toLuaFile ./lua/vimtex.lua;
        
             }
             {
                 plugin = nvim-dap;
                 config = toLuaFile ./lua/dap.lua;
             }
             {
                 plugin = cmake-tools-nvim;
                 config = toLuaFile ./lua/cmake-tools.lua;
             }
        
         ] ++ treesitter-parsers;
        
         extraPackages = with pkgs; [
             xclip
             wl-clipboard
             fzf
             cmake
             gdb
        
             #lps
             clang-tools_17
             cmake-language-server
             sqls
             lua-language-server
             biome
             tailwindcss-language-server
             nodePackages_latest.typescript-language-server
             nodePackages_latest.vls
             docker-compose-language-service
             arduino-language-server
             python311Packages.python-lsp-server
             vscode-extensions.rust-lang.rust-analyzer
             nil
         ];

    };
}
