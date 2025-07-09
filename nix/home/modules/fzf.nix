{ config, ... }:
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
      "--header-border double"
      "--input-border double"
      "--list-border double"
      "--preview-border double"

      "--preview 'bat --style=numbers --color=always {}'"

      "--multi"
    ];
  };
}
