{
  config,
  inputs,
  pkgs,
  lib,
  username,
  homeDirectory,
  ...
}:
{
  nix = {
    gc.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    # Temporary fix for direnv failing to build
    # Borrowed from https://github.com/dvcorreia/nix-config/commit/a4fe9902a3bee18fcde502eb3d5313c328f419ea
    # Tracking for fix: https://nixpk.gs/pr-tracker.html?pr=502769
    overlays = [
      (final: prev: {
        direnv = prev.direnv.overrideAttrs (old: {
          postPatch = ''
            substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
          '';
        });
      })
    ];
  };

  lib.custom = {
    isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

    mkDotfilesSymlink =
      symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/${symlink}";
    mkCustomSymlink =
      symlink: config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles_custom/${symlink}";

    palette =
      (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
      .${config.catppuccin.flavor}.colors;
  };

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./modules
  ];

  home = {
    username = username;
    homeDirectory = homeDirectory;

    # Check https://nix-community.github.io/home-manager/release-notes.xhtml before updating
    stateVersion = "26.05";
    sessionPath = [ "${homeDirectory}/dotfiles/bin" ];
    packages = [
      pkgs.awscli2
      pkgs.devenv
      pkgs.fd
      pkgs.gnumake
      pkgs.imagemagick
      pkgs.jq
      pkgs.nodejs
      pkgs.ripgrep
      pkgs.sesh
      pkgs.tree
      pkgs.vim
      pkgs.wget

      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.mononoki
    ];
  };

  fonts.fontconfig.enable = true;
}
