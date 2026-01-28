{ ... }:
let
  emailBase = "askinsjacqueline";
in
{
  programs.git = {
    enable = true;

    settings = {
      advice.skippedCherryPicks = false;
      branch.sort = "-committerdate";
      diff = {
        algorithm = "histogram";
        colorMoved = "default";
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      push.autosetupremote = true;
      rerere.enabled = true;
      rebase.autoStash = true;
      user = {
        email = "${emailBase}@gmail.com";
        name = "Jacqueline Askins";
      };
    };

    ignores = [
      ".DS_Store"
      ".git"
      ".ignore"
      ".repro"
      ".solargraph.yml"
    ];
  };
}
