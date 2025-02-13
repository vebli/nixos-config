{config, pkgs, inputs, ...}:
{
    home.packages = with pkgs; [
        emacs
        texlivePackages.dvisvgm 
        emacsPackages.elsa
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

    home.file."gdb-conf" = {
        target = ".gdbinit";
        text = ''
            set disassembly-flavor intel
        '';
    };
}
