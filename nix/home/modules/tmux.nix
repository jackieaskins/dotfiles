{
  config,
  lib,
  pkgs,
  ...
}:
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

  palette = lib.importJSON "${config.catppuccin.sources.palette}/palette.json";
  lightColor = color: palette.latte.colors.${color}.hex;
  darkColor = color: palette.${config.catppuccin.flavor}.colors.${color}.hex;

  getColor = color: "#{?#{==:#(cat ~/.appearance),light},${lightColor color},${darkColor color}}";

  suspendedStyle = ''bg=${getColor "base"}\\,fg=${getColor "overlay1"} dim'';
  suspendedActiveWindowStyle = ''bg=${getColor "base"}\\,fg=${getColor "blue"} dim'';
in
{
  catppuccin.tmux.enable = false;

  programs.tmux = {
    enable = true;
    extraConfig = # tmux
      ''
        # Styles
        set -g message-style "fg=${getColor "sky"},bg=${getColor "surface0"},align=centre"
        set -g message-command-style "fg=${getColor "sky"},bg=${getColor "surface0"},align=centre"

        set -g pane-border-style "fg=${getColor "surface0"}"
        set -g pane-active-border-style "fg=${getColor "blue"}"

        set -g mode-style "fg=${getColor "surface0"},bg=${getColor "blue"},bold"

        ## Status Line Styles
        set -g status-style "bg=${getColor "base"}"

        set -g status-left-style "fg=${getColor "base"},bg=${getColor "pink"}"

        set -g @branch-style "fg=${getColor "base"},bg=${getColor "mauve"}"
        set -g @host-style "fg=${getColor "base"},bg=#{?client_prefix,${getColor "peach"},${getColor "green"}}"

        set -g window-status-activity-style "fg=${getColor "text"},bg=${getColor "base"},none"
        set -g window-status-style "fg=${getColor "text"},bg=${getColor "surface0"}"
        set -g window-status-current-style "fg=${getColor "base"},bg=${getColor "blue"}"

        source $HOME/dotfiles/tmux.conf
      '';
    plugins = [
      pkgs.tmuxPlugins."vim-tmux-navigator"
      {
        plugin = tmux-suspend;
        extraConfig = # tmux
          ''
            set -g @suspend_key "M-Enter"

            set -g @suspend_suspended_options " \
             status-left-style:gw:${suspendedStyle}, \
             window-status-current-style:gw:${suspendedActiveWindowStyle}, \
             window-status-style:gw:${suspendedStyle}, \
             @branch-style::${suspendedStyle}, \
             @host-style::${suspendedStyle}, \
            "
          '';
      }
    ];
  };
}
