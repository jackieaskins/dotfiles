{
  config,
  pkgs,
  inputs,
  ...
}:
{
  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # darwin-rebuild changelog
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ config.system.primaryUser ];
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    gc.automatic = true;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.ice-bar
    pkgs.iina
    pkgs.keycastr
    pkgs.vscodium
  ];

  fonts.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.mononoki
  ];

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  imports = [
    /etc/nix-custom/configuration.nix
    ./modules
    ./homebrew.nix
    ./system-preferences.nix
  ];
}
