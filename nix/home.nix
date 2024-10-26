{
  config,
  home-dir,
  inputs,
  pkgs,
  user,
  ...
}:
let
  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
in
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = user;
  home.homeDirectory = home-dir;

  home.sessionPath = [ "${home-dir}/dotfiles/bin" ];

  home.packages = [
    pkgs.autossh
    pkgs.awscli2
    pkgs.fd
    pkgs.lua-language-server
    pkgs.neovim
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.pre-commit
    pkgs.ripgrep
    pkgs.stylua
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${home-dir}/dotfiles/nvim";
    ".config/karabiner".source = config.lib.file.mkOutOfStoreSymlink "${home-dir}/dotfiles/karabiner";
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${home-dir}/dotfiles/starship.toml";
    ".hammerspoon".source = config.lib.file.mkOutOfStoreSymlink "${home-dir}/dotfiles/hammerspoon";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nix-update = "nix flake update --flake $HOME/dotfiles/nix";
      nix-rebuild-darwin = "darwin-rebuild switch --flake $HOME/dotfiles/nix#personal --impure";
      nix-rebuild-home = "home-manager switch --flake $HOME/dotfiles/nix --impure";
      nix-rebuild-all = "nix-rebuild-darwin && nix-rebuild-home";
    };
    initExtra = # zsh
      ''
        source $HOME/dotfiles/zshrc
      '';
  };

  programs.bat = {
    enable = true;
    inherit catppuccin;
    config = {
      theme = "Catppuccin Macchiato";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.git/*' --glob '!*.class'";
    defaultOptions = [
      "--highlight-line"
      "--cycle"
      "--marker +"
      "--pointer '>'"
      "--border double"
      "--layout reverse"
      "--preview 'bat --style=numbers --color=always {}'"
      "--multi"
    ];
    colors = {
      "bg+" = "#363a4f";
      border = "blue";
      "fg+" = "#cad3f5";
      gutter = "#24273a";
      header = "magenta";
      hl = "blue";
      "hl+" = "blue";
      info = "magenta";
      label = "blue";
      marker = "blue";
      pointer = "blue";
      "preview-scrollbar" = "blue";
      prompt = "blue";
      scrollbar = "blue";
      separator = "magenta";
      spinner = "magenta";
    };
  };

  programs.git = {
    enable = true;
    delta = {
      enable = true;
      inherit catppuccin;
      options = {
        features = "catppuccin-macchiato";
        commit-decoration-style = "yellow box ul";
        commit-style = "yellow";
        file-decoration-style = "blue ul";
        file-style = "blue";
        hunk-header-style = "omit";
        navigate = true;
        true-color = "always";
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    extraConfig = # tmux
      ''
        source $HOME/dotfiles/tmux.conf
      '';
    plugins = [ pkgs.tmuxPlugins."vim-tmux-navigator" ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
