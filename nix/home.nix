{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = "jackie";
  home.homeDirectory = "/Users/jackie";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.tmux
  ];

  home.file = {
    ".config/tmux/tmux.conf".source = ~/dotfiles/tmux.conf;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
