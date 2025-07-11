{
  config,
  inputs,
  pkgs,
  ...
}:
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.gc.automatic = true;

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
    "dotfiles/hammerspoon/custom.lua".source =
      config.lib.custom.mkCustomSymlink "hammerspoon-custom.lua";

    "./config/karabiner".source = config.lib.custom.mkDotfilesSymlink "karabiner";
  };

  home.packages = [
    pkgs.autossh
    pkgs.awscli2
    pkgs.devenv
    pkgs.fd
    pkgs.imagemagick
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
