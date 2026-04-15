{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
in
{
  nix = {
    gc.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
