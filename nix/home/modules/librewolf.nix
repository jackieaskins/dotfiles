{ lib, ... }:
let
  mkExtension =
    {
      id,
      defaultArea ? "menupanel",
      private ? false,
    }:
    {
      "${id}" = {
        default_area = defaultArea;
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
        installation_mode = "force_installed";
        private_browsing = private;
      };
    };
in
{
  programs.librewolf = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      # Find extension ids in about:support
      ExtensionSettings = lib.mkMerge (
        map mkExtension [
          {
            id = "uBlock0@raymondhill.net";
            private = true;
          }
          # CSS Stacking Context Inspector
          { id = "{239a3710-9399-4d6e-a7ba-de533a5177fb}"; }
          {
            id = "addon@darkreader.org";
            defaultArea = "navbar";
          }
          { id = "@testpilot-containers"; }
          { id = "password-manager-firefox-extension@apple.com"; }
          {
            id = "MaximizeVideo@ettoolong";
            defaultArea = "navbar";
          }
          { id = "@react-devtools"; }
          { id = "snaplinks@snaplinks.mozdev.org"; }
          {
            id = "vimium-c@gdh1995.cn";
            defaultArea = "navbar";
          }
          # WAVE Evaluation Tool
          { id = "{9bbf6724-d709-492e-a313-bfed0415a224}"; }
        ]
      );

      SearchEngines = {
        Add = [
          {
            Name = "MyNixOS";
            Alias = "@nix";
            URLTemplate = "https://mynixos.com/search?q={searchTerms}";
          }
          {
            Name = "GitHub";
            Alias = "@github";
            URLTemplate = "https://github.com/search?type=code&q={searchTerms}";
          }
        ];
      };
    };

    settings = {
      "sidebar.revamped" = true;
      "sidebar.verticalTabs" = true;

      "privacy.resistFingerprinting" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
    };
  };
}
