{pkgs, ...}:
{
    programs.librewolf ={
        enable = true;
        package = pkgs.librewolf;
        languagePacks = ["de" "en-GB"];
        settings = {
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cache" = false;
            "privacy.clearOnShutdown.downloads" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "network.cookie.lifetimePolicy" = 0;
            "browser.newtabpage.activity-stream.feeds.topsites" = true;
            "browser.newtabpage.activity-stream.default.sites" = "https://www.youtube.com/,https://chatgpt.com,https://search.nixos.org/packages,https://home-manager-options.extranix.com/,https://github.com";
        };
    };
}
