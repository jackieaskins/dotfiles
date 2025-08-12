{ ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./catppuccin.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./hammerspoon.nix
    ./jankyborders.nix
    ./karabiner.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./tmuxinator.nix
    ./wezterm.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
