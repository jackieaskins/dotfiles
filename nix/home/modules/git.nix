{ ... }:
{
  programs.git = {
    enable = true;

    extraConfig = {
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
    };

    delta = {
      enable = true;
      options = {
        commit-decoration-style = "yellow box ul";
        commit-style = "yellow";
        file-decoration-style = "blue ul";
        file-style = "blue";
        hunk-header-style = "omit";
        navigate = true;
        true-color = "always";
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
