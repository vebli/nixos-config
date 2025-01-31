{pkgs, var, ...}:
{
    nix.registry."devshells" = {
        from = {
            id = "devshells";
            type = "indirect";
        };
        to = { 
            path = var.path.root + "modules/system/devshells";   
            type = "path";
        };
        exact = true;
    };
}
