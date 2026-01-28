{
  config,
  pkgs,
  inputs,
  lib,
  homeDirectory,
  username,
  ...
}:
{
  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # darwin-rebuild changelog
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    primaryUser = username;
  };
  users.users.${username}.home = homeDirectory;

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
  environment.enableAllTerminfo = true;

  environment.systemPackages = [
    pkgs.discord
    pkgs.iina
    pkgs.keycastr
    pkgs.mas
    pkgs.qmk
    pkgs.vscodium
  ];

  homebrew.casks = [
    "logitune"
    "virtualbuddy"
  ];

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system.activationScripts.postActivation.text =
    let
      loginItems = [
        "/Applications/BetterDisplay.app"
        "/Applications/DockDoor.app"
        "/Applications/Hammerspoon.app"
        "/Applications/Nix Apps/Ice.app"
        "/Applications/Raycast.app"
        "/Applications/Rocket.app"
        "/Applications/WezTerm.app"
      ];
    in
    lib.strings.concatMapStringsSep "\n" (path: ''
      osascript -e '
        tell application "System Events" to make login item at end with properties { name: "${path}", path: "${path}", hidden: true }
      '
    '') loginItems;

  imports = [
    ./modules
    ./system-preferences.nix
  ];
}
