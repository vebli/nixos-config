{config, pkgs-unstable, inputs, ...}:
{
    home.packages = with pkgs-unstable; [
        emacs
        texlivePackages.dvisvgm 
        emacs.pkgs.elsa
        asm-lsp
        cmake-language-server
        arduino-language-server
        vscode-extensions.vue.volar
        tailwindcss-language-server
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        sqls
        nil
        nixd
        vscode-extensions.rust-lang.rust-analyzer
        lua-language-server
        python312Packages.python-lsp-server
        ols
        alejandra
        vscode-extensions.vue.volar
    ];
}
