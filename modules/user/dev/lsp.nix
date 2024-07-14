{config, pkgs, ...}:
{
    home.packages = with pkgs; [
        cmake-language-server
        arduino-language-server
        nodePackages_latest.vls
        nodePackages_latest.volar
        tailwindcss-language-server
        nodePackages_latest.typescript-language-server
        sqls
        nil
        vscode-extensions.rust-lang.rust-analyzer
        lua-language-server
    ];
}
