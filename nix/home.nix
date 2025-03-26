{
  config,
  email,
  fullName,
  homeDirectory,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  mkSymlink = symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/${symlink}";
  mkCustomSymlink =
    symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles_custom/${symlink}";
  getPkgsFromJsonFile =
    filepath:
    lib.attrsets.mapAttrsToList (name: value: pkgs.${value.pkg}) (
      lib.attrsets.filterAttrs (name: value: (lib.hasAttrByPath [ "pkg" ] value)) (
        lib.importJSON filepath
      )
    );

  flakePath = "${homeDirectory}/dotfiles/nix";

  palette =
    (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
    .${config.catppuccin.flavor}.colors;
in
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.gc.automatic = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionPath = [
    "${homeDirectory}/dotfiles/bin"
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    starship.enable = false;
    tmux.enable = false;
    zsh-syntax-highlighting.enable = false;
  };

  home.packages = lib.lists.flatten [
    (getPkgsFromJsonFile "${flakePath}/lsp-servers.json")
    (getPkgsFromJsonFile "${flakePath}/formatters.json")
    [
      pkgs.autossh
      pkgs.awscli2
      pkgs.devenv
      pkgs.direnv
      pkgs.fd
      pkgs.imagemagick
      pkgs.neovim
      pkgs.pre-commit
      pkgs.ripgrep
      pkgs.sesh
      pkgs.tree-sitter
      pkgs.vivid
    ]
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
    };
    initExtra = # zsh
      ''
        export LS_COLORS="$(vivid generate catppuccin-${config.catppuccin.flavor})"

        function nix-switch {
          if [[ $(uname) == "Darwin" ]]; then
            darwin-rebuild switch --flake ${flakePath} --impure
          else
            home-manager switch --flake ${flakePath} --impure
          fi
        }

        function nix-update {
          nix flake update --commit-lock-file --flake ${flakePath}
          nix-switch
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
      "--header-border double"
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
