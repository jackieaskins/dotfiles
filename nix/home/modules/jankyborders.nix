{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.jankyborders = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    settings = {
      active_color = "0xFF${lib.toUpper (lib.strings.removePrefix "#" config.lib.custom.palette.green.hex)}";
      hidpi = "on";
      width = 8;
    };
  };
}
