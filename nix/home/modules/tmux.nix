{ pkgs, ... }:
let
  tmux-suspend = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-suspend";
    version = "main";
    rtpFilePath = "suspend.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "tmux-suspend";
      rev = "main";
      hash = "sha256-+1fKkwDmr5iqro0XeL8gkjOGGB/YHBD25NG+w3iW+0g=";
    };
  };
in
{
  catppuccin.tmux.enable = false;

  programs.tmux = {
    enable = true;
    extraConfig = # tmux
      ''
        source $HOME/dotfiles/tmux.conf
      '';
    plugins = [
      pkgs.tmuxPlugins."vim-tmux-navigator"
      tmux-suspend
    ];
    tmuxinator = {
      enable = true;
    };
  };

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
