{ config, ... }:
{
  home.file.".config/wezterm".source = config.lib.custom.mkDotfilesSymlink "wezterm";
}
