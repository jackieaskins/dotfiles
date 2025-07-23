{ config, ... }:
{
  home.file.".config/karabiner".source = config.lib.custom.mkDotfilesSymlink "karabiner";
}
