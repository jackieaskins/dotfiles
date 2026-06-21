{ ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./catppuccin.nix
    ./delta.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./hammerspoon.nix
    ./jankyborders.nix
    ./karabiner.nix
    ./kitty.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./tmuxinator.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
