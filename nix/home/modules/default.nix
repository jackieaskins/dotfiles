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
    ./neovim
    ./opencode.nix
    ./starship.nix
    ./tmux.nix
    ./tmuxinator.nix
    ./wezterm.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
