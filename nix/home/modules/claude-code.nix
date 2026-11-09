{ inputs, ... }:
{
  home.file = {
    ".claude/themes" = {
      source = "${inputs.catppuccin-claude-code}/themes";
      recursive = true;
    };

    ".claude/settings.json".text = builtins.toJSON {
      theme = "custom:catppuccin";
    };
  };
}
