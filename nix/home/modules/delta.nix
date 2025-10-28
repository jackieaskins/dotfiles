{ ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
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
}
