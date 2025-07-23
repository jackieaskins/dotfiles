{ config, ... }:
{
  home.file.".config/starship.toml".source = config.lib.custom.mkDotfilesSymlink "starship.toml";

  catppuccin.starship.enable = false;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
