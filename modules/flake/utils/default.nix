{lib, ... }: with builtins; rec
{

    #Takes list of files and removes default.nix and keeps nix files
    findModules = files: let
        nixFiles = filter (file: lib.strings.hasSuffix ".nix" file) files; 
        filteredFiles= filter (file: !lib.strings.hasSuffix "default.nix" file) nixFiles; 
        in filteredFiles;

    # Returns list of sibling nix files ignoring default.nix
    findSiblings = path: let
        files = map (f: "${path}/${f}")(attrNames (readDir path));
        file = findModules [path]; 
        filteredFiles = findModules files;
    in
        if (lib.filesystem.pathIsRegularFile path) then file else filteredFiles;

    importSiblings = path: 
    {imports = map 
        (file: import (toPath "${path}/${file}")) 
        (findSiblings path);
    };

    # Takes a list of directory paths and returns list with direct children of given paths.
    imports = paths: concatMap findSiblings paths;
}
