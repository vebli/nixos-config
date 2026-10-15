{config, pkgs, ...}: 
{
    programs.librewolf = {
        enable = true;
        languagePacks = ["en-GB" "de"];
        profiles.vebly = {
            isDefault = true;
            handlers = {
                force = true;
                mimeTypes = {
                    "application/pdf" = {
                        action = 3;
                        ask = false;
                    };
                };
            };
            search = {
                force = true;
                default = "ddg";
            };
            settings = {
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
            };
            userChrome = ''
#TabsToolbar { display: none !important; } 
                '';
        };
    };
}
