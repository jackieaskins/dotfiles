{
  pkgs,
  inputs,
  ...
}:
{
  # Used for backwards compatibility, please read the changelog before changing.
  # darwin-rebuild changelog
  system.stateVersion = 6;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  nix.settings.experimental-features = "nix-command flakes";
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.gc.automatic = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

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
