{ config, lib, ... }:
{
  services.jankyborders = {
    enable = config.lib.custom.isDarwin;
    settings = {
      active_color = "0xFF${lib.toUpper (lib.strings.removePrefix "#" config.lib.custom.palette.mauve.hex)}";
      hidpi = "on";
    };
  };
}
