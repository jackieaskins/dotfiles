{
  config,
  email,
  fullName,
  homeDirectory,
  inputs,
  pkgs,
  username,
  ...
}:
let
  flakePath = "$HOME/dotfiles/nix";
  mkSymlink = symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/${symlink}";
  mkCustomSymlink =
    symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles_custom/${symlink}";
in
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionPath = [
    "${homeDirectory}/dotfiles/bin"
  ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    starship.enable = false;
  };

  home.packages = [
    pkgs.autossh
    pkgs.awscli2
    pkgs.deno
    pkgs.fd
    pkgs.go
    pkgs.jdk
    pkgs.neovim
    pkgs.nodejs_18
    pkgs.pre-commit
    pkgs.ripgrep
    pkgs.sesh

    # Neovim Language Servers
    pkgs.emmet-language-server # emmet
    pkgs.gopls # gopls
    pkgs.jdt-language-server # jdtls
    pkgs.lua-language-server # lua_ls
    pkgs.nil # nil_ls
    pkgs.nixd # nixd
    pkgs.nodePackages.graphql-language-service-cli # graphql
    pkgs.pyright # pyright
    pkgs.ruby-lsp # ruby_lsp
    pkgs.solargraph # solargraph
    pkgs.svelte-language-server # svelte
    pkgs.tailwindcss-language-server # tailwindcss
    pkgs.taplo-lsp # taplo
    pkgs.typescript # typescript-tools
    pkgs.vim-language-server # vimls
    pkgs.vscode-langservers-extracted # cssls, eslint, html, jsonls
    pkgs.yaml-language-server # yamlls

    # Neovim Formatters
    pkgs.libclang # clang-format
    pkgs.nixfmt-rfc-style # nixfmt
    pkgs.prettierd # prettierd
    pkgs.stylua # stylua
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  home.file = {
    ".config/nvim".source = mkSymlink "nvim";
    ".config/karabiner".source = mkSymlink "karabiner";
    ".config/starship.toml".source = mkSymlink "starship.toml";
    ".hammerspoon".source = mkSymlink "hammerspoon";
    "dotfiles/nvim/lua/custom.lua".source = mkCustomSymlink "nvim-custom.lua";
    "dotfiles/hammerspoon/custom.lua".source = mkCustomSymlink "hammerspoon-custom.lua";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nu = "nix flake update --commit-lock-file --flake ${flakePath}";
      drs = "darwin-rebuild switch --flake ${flakePath}";
      hms = "home-manager switch --flake ${flakePath}";
      ns = "darwin-rebuild switch --flake ${flakePath} && home-manager switch --flake ${flakePath}";
      nus = "nix flake update --flake ${flakePath} && darwin-rebuild switch --flake ${flakePath} && home-manager switch --flake ${flakePath}";
    };
    initExtra = # zsh
      ''
        source $HOME/dotfiles/zshrc
      '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "Mononoki Nerd Font";
        size = 14;
      };
      window = {
        dynamic_padding = true;
        option_as_alt = "Both";
        padding.y = 10;
      };
    };
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
  };

  programs.git = {
    enable = true;
    extraConfig = {
      advice.skippedCherryPicks = false;
      branch.sort = "-committerdate";
      diff.colorMoved = "default";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      rerere.enabled = true;
      rebase.autoStash = true;
    };
    delta = {
      enable = true;
      options = {
        commit-decoration-style = "yellow box ul";
        commit-style = "yellow";
        file-decoration-style = "blue ul";
        file-style = "blue";
        hunk-header-style = "omit";
        navigate = true;
        true-color = "always";
      };
    };
    ignores = [
      ".DS_Store"
      ".git"
      ".ignore"
      ".repro"
      ".solargraph.yml"
    ];
    userEmail = email;
    userName = fullName;
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
