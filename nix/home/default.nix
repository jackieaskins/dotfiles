{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
  isNotDarwin = !config.lib.custom.isDarwin;
in
{
  nix = {
    gc.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = lib.mkIf isNotDarwin pkgs.nix;
    settings.experimental-features = lib.mkIf isNotDarwin "nix-command flakes";
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
    /etc/nix-custom/home.nix
    ./modules
  ];

  home = {
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
    ]
    ++ (pkgs.lib.optionals (!config.lib.custom.isDarwin) pkgs.clang);
  };

  fonts.fontconfig.enable = true;
}
