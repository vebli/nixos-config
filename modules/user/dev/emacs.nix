{config, pkgs-unstable, inputs, ...}:
{
    home.packages = with pkgs-unstable; [
        emacs

        # LSP
        clang-tools
        texlivePackages.dvisvgm 
        emacs.pkgs.elsa
        asm-lsp
        clojure-lsp
        cmake-language-server
        vscode-extensions.vue.volar
        tailwindcss-language-server
        nodePackages_latest.typescript-language-server
        sqls
        python314Packages.sqlparse
        nixd
        vscode-extensions.rust-lang.rust-analyzer
        lua-language-server
        python312Packages.python-lsp-server
        vscode-extensions.vue.volar
        ols


        # Formatter
        alejandra
        cljfmt
    ];
}
