{ ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./catppuccin.nix
    ./delta.nix
    ./devenv.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./hammerspoon.nix
    ./jankyborders.nix
    ./karabiner.nix
    ./kitty.nix
    ./nix-plist-manager.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./tmuxinator.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
