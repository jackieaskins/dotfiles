{
  config,
  inputs,
  pkgs,
  ...
}:
let
  wezterm = inputs.wezterm-nightly-overlay.packages.${pkgs.system}.default;
in
{
  home.packages = [
    wezterm
    wezterm.terminfo
  ];

  home.file.".config/wezterm".source = config.lib.custom.mkDotfilesSymlink "wezterm";
}
