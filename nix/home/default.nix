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

    stateVersion = "25.05";
    sessionPath = [ "${homeDirectory}/dotfiles/bin" ];
    packages = [
      pkgs.autossh
      pkgs.awscli2
      pkgs.devenv
      pkgs.fd
      pkgs.imagemagick
      pkgs.gnumake
      pkgs.jq
      pkgs.ripgrep
      pkgs.sesh
      pkgs.tree
      pkgs.vim
      pkgs.wget

      pkgs.nerd-fonts.hack
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.mononoki

      inputs.fenix.packages.${pkgs.stdenv.hostPlatform.system}.minimal.toolchain
    ];
  };

  fonts.fontconfig.enable = true;
}
