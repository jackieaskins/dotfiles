{ ... }:
{
  programs.tmux.tmuxinator.enable = true;

  home.file."/.config/tmuxinator/dotfiles.yml" = {
    text = # zsh
      ''
        name: dotfiles
        root: ~

        windows:
          - dots:
              root: ~/dotfiles
          - custom:
              root: ~/dotfiles_custom
          - plugins:
              root: ~/.local/share/nvim/lazy
      '';
  };
}
