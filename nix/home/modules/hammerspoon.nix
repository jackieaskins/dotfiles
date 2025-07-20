{ config, ... }:
{
  home.file = {
    ".hammerspoon".source = config.lib.custom.mkDotfilesSymlink "hammerspoon";
    "dotfiles/hammerspoon/custom.lua".source = config.lib.custom.mkCustomSymlink "hammerspoon.lua";
  };
}
