{
  config,
  inputs,
  pkgs,
  ...
}:
{
  nix = {
    gc.automatic = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };

  home.stateVersion = "25.05";

  home.sessionPath = [
    "${config.home.homeDirectory}/dotfiles/bin"
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home.file = {
    ".hammerspoon".source = config.lib.custom.mkDotfilesSymlink "hammerspoon";
    "dotfiles/hammerspoon/custom.lua".source = config.lib.custom.mkCustomSymlink "hammerspoon.lua";

    "./config/karabiner".source = config.lib.custom.mkDotfilesSymlink "karabiner";
  };

  home.packages = [
    pkgs.autossh
    pkgs.awscli2
    pkgs.clang
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
  ];

  imports = [
    /etc/nix-custom/home.nix
    ./utils.nix
    ./modules
  ];
}
