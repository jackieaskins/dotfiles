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
      nix-switch = "sudo darwin-rebuild switch --flake /etc/nix-darwin#darwin --impure";
      nix-update = "sudo nix flake update --flake /etc/nix-darwin";
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
