{
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.default.bookmarks = {
    };
    profiles.default.containers = {
    };
    profiles.default.extensions = {
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        darkreader
        vimium
      ];
    };
    profiles.default.handlers = {
    };
    profiles.default.search = {
      default = "google";
      engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };
        bing.metaData.hidden = true;
        google.metaData.alias = "@g";
      };
    };
    profiles.default.settings = {
    };
  };
}
