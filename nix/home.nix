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
  mkSymlink = symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/${symlink}";
  mkCustomSymlink =
    symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles_custom/${symlink}";

  flakePath = "$HOME/dotfiles/nix";

  palette =
    (pkgs.lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
    .${config.catppuccin.flavor}.colors;

  tmux-tea = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-tea";
    rtpFilePath = "tea.tmux";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "tmux-tea";
      rev = "main";
      hash = "sha256-UiuHl9E8JqGJHSYRPzR0E+woo6e2eG6fMSSBfLexF5w=";
    };
  };
in
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
    tmux.enable = false;
    zsh-syntax-highlighting.enable = false;
  };

  home.packages = [
    pkgs.autossh
    pkgs.awscli2
    pkgs.deno
    pkgs.fd
    pkgs.neovim
    pkgs.pre-commit
    pkgs.ripgrep
    pkgs.rustup

    # Neovim Language Servers
    pkgs.emmet-language-server # emmet
    pkgs.gopls # gopls
    pkgs.jdt-language-server # jdtls
    pkgs.lua-language-server # lua_ls
    pkgs.nil # nil_ls
    pkgs.nixd # nixd
    # pkgs.nodePackages.graphql-language-service-cli # graphql
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

  home.file = {
    ".config/nvim".source = mkSymlink "nvim";
    ".config/karabiner".source = mkSymlink "karabiner";
    ".config/starship.toml".source = mkSymlink "starship.toml";
    ".hammerspoon".source = mkSymlink "hammerspoon";
    ".config/ghostty".source = mkSymlink "ghostty";

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
      mux = "tmuxinator";
      nix-update = "nix flake update --commit-lock-file --flake ${flakePath}";
    };
    initExtra = # zsh
      ''
        function nix-switch {
          if [[ $(uname) == "Darwin" ]]; then
            darwin-rebuild switch --flake ${flakePath} --impure
          else
            home-manager switch --flake ${flakePath} --impure
          fi
        }

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
    colors = {
      border = "blue";
      gutter = "${palette.base.hex}";
    };
    defaultOptions = [
      "--highlight-line"
      "--cycle"
      "--marker +"
      "--pointer '>'"
      "--layout reverse"

      "--border none"
      "--input-border double"
      "--list-border double"
      "--preview-border double"

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
    extraConfig = # tmux
      ''
        source $HOME/dotfiles/tmux.conf
      '';
    plugins = [
      pkgs.tmuxPlugins."vim-tmux-navigator"
      {
        plugin = tmux-tea;
        extraConfig = # tmux
          ''
            set -g @tea-alt-bind "false"
          '';
      }
    ];
    tmuxinator = {
      enable = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
