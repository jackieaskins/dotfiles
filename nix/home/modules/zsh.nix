{ config, pkgs, ... }:
{
  catppuccin.zsh-syntax-highlighting.enable = false;

  home.packages = [
    pkgs.vivid
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = false;

    shellAliases =
      let
        darwinFlake = "/etc/nix-darwin";
        linuxFlake = "${config.home.homeDirectory}/dotfiles/nix";
      in
      {
        mux = "tmuxinator";
        get-bundle-id = "mdls -name kMDItemCFBundleIdentifier -r";

        nix-repl = "nix repl --expr 'import <nixpkgs>{}'";
        nix-switch =
          if config.lib.custom.isDarwin then
            "sudo darwin-rebuild switch --flake ${darwinFlake}#darwin --impure"
          else
            "home-manager switch --flake ${linuxFlake}#linux --impure";
        nix-update =
          if config.lib.custom.isDarwin then
            "sudo nix flake update --flake ${darwinFlake}"
          else
            "nix flake update --flake ${linuxFlake}";
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
