{ config, lib, ... }:
{
  services.jankyborders = {
    enable = config.lib.custom.isDarwin;
    settings = {
      active_color = "0xFF${lib.toUpper (lib.strings.removePrefix "#" config.lib.custom.palette.green.hex)}";
      hidpi = "on";
      width = 8;
    };
  };
}
