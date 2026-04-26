{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    extraPackages = [
      pkgs.bat-extras.batdiff
      pkgs.bat-extras.batgrep
      pkgs.bat-extras.batman
    ];
    syntaxes = {
      tmux = {
        src = pkgs.fetchFromGitHub {
          owner = "gerardroche";
          repo = "sublime-tmux";
          rev = "master";
          hash = "sha256-c7WJOmrYi8MLCU19O8KGNfV7YxSO+SdVmxtwsdkIxtQ=";
        };
        file = "Tmux.sublime-syntax";
      };
    };
  };
}
