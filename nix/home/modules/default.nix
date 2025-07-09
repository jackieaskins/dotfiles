{ ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./jankyborders.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./wezterm.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
