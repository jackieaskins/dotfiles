{ ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./jankyborders.nix
    ./neovim
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
