{ config, ... }:
let
  BORDER_STYLE = config.programs.zsh.sessionVariables.BORDER_STYLE;
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!*.class'";
    colors = {
      border = "blue";
      gutter = config.lib.custom.palette.base.hex;
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
