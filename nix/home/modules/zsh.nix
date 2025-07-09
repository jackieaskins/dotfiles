{ config, pkgs, ... }:
{
  catppuccin.zsh-syntax-highlighting.enable = false;

  home.packages = [
    pkgs.vivid
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = false;

    shellAliases = {
      mux = "tmuxinator";
    };

    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    initContent = # zsh
      ''
        export LS_COLORS="$(vivid generate catppuccin-${config.catppuccin.flavor})"

        source $HOME/dotfiles/zshrc
      '';
  };
}
