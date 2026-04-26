{
  config,
  lib,
  pkgs,
  ...
}:
let
  capitalize =
    str:
    if str == "" then
      ""
    else
      let
        first = lib.strings.substring 0 1 str;
        rest = lib.strings.substring 1 (lib.strings.stringLength str - 1) str;
      in
      lib.strings.toUpper first + rest;

  generateThemeFile =
    flavor:
    let
      colors = config.lib.custom.getPalette flavor;
      accent = colors.blue.hex;
    in
    {
      text = # kitty
        ''
          include ${pkgs.kitty-themes}/share/kitty-themes/themes/Catppuccin-${capitalize flavor}.conf

          cursor none

          # Tab Bar
          tab_bar_background ${colors.base.hex}

          active_tab_font_style normal
          active_tab_foreground ${accent}
          active_tab_background ${colors.surface0.hex}

          inactive_tab_font_style normal
          inactive_tab_foreground ${colors.surface1.hex}
          inactive_tab_background ${colors.base.hex}
        '';
    };
in
{
  catppuccin.kitty.enable = false;
  home.packages = [ pkgs.kitty ];
  home.file = {
    ".config/kitty".source = config.lib.custom.mkDotfilesSymlink "kitty";

    "dotfiles/kitty/light-theme.auto.conf" = generateThemeFile "latte";
    "dotfiles/kitty/dark-theme.auto.conf" = generateThemeFile config.catppuccin.flavor;
    "dotfiles/kitty/no-preference-theme.auto.conf" = generateThemeFile config.catppuccin.flavor;
  };
}
