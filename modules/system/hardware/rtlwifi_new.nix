{config, pkgs, ...}:
let
    repo = pkgs.fetchFromGithub {
        owner = "ghotiv";
        repo = "rtlwifi_new";
        rev = "master";
        sha256 = "";
    };
in
{
    
}
