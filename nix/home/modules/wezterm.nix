{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wezterm = inputs.wezterm-nightly-overlay.packages.${pkgs.system}.default;
in
{
  home.file.".config/wezterm".source = config.lib.custom.mkDotfilesSymlink "wezterm";

  home.packages = lib.mkIf (!config.lib.custom.isDarwin) [
    wezterm
    wezterm.terminfo
  ];
}
