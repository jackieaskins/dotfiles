{ config, lib, ... }:
let
  BORDER_STYLE = config.programs.zsh.sessionVariables.BORDER_STYLE;
  palette = config.lib.custom.palette;
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!*.class'";
    colors = {
      border = lib.mkForce palette.blue.hex;
      gutter = palette.base.hex;
      pointer = palette.rosewater.hex;
      "bg+" = palette.surface0.hex;
      prompt = palette.mauve.hex;
      info = palette.mauve.hex;
    };
    defaultOptions = [
      "--highlight-line"
      "--cycle"
      "--marker +"
      "--pointer '>'"
      "--layout reverse"

      "--border none"
      "--header-border ${BORDER_STYLE}"
      "--input-border ${BORDER_STYLE}"
      "--list-border ${BORDER_STYLE}"
      "--preview-border ${BORDER_STYLE}"

      "--preview 'bat --style=numbers --color=always {}'"

      "--multi"
    ];
  };
}
