    {pkgs, ...}: pkgs.writeShellScriptBin "hellow" /*bash*/ ''
    echo hello!
    ''
