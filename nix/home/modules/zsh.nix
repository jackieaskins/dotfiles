{ config, pkgs, ... }:
{
  catppuccin.zsh-syntax-highlighting.enable = false;

  home.packages = [
    pkgs.vivid
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = false;

    sessionVariables = {
      LS_COLORS = "$(vivid generate catppuccin-${config.catppuccin.flavor})";
    };

    shellAliases = {
      mux = "tmuxinator";
      get-bundle-id = "mdls -name kMDItemCFBundleIdentifier -r";

      nix-repl = "nix repl --expr 'import <nixpkgs>{}'";
      nix-update = "nix flake update --flake ~/dotfiles/nix";
      nix-darwin-switch = "sudo darwin-rebuild switch";
      nix-hm-switch = "home-manager switch";
    };

    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    initContent = # zsh
      ''
        source $HOME/dotfiles/zshrc
      '';
  };
}
