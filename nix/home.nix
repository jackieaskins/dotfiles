{
  inputs,
  config,
  pkgs,
  user,
  home-dir,
  ...
}:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = user;
  home.homeDirectory = home-dir;

  home.sessionPath = [ "${home-dir}/dotfiles/bin" ];

  home.packages = [
    pkgs.autossh
    pkgs.fd
    pkgs.neovim
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.pre-commit
    pkgs.ripgrep
    pkgs.stylua
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${home-dir}/dotfiles/nvim";
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
    };
    initExtra = # zsh
      ''
        source $HOME/dotfiles/zshrc
      '';
  };

  programs.bat.enable = true;

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
