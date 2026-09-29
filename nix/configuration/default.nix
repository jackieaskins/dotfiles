{
  config,
  pkgs,
  inputs,
  lib,
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

    package = pkgs.nixVersions.latest;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "firefox"
      "hammerspoon"
      "helium-browser"
      "karabiner-elements"
      "kitty"
      "sf-symbols"
      "vorssaint"
      "vscodium"
    ];
  };

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system.activationScripts.postActivation.text =
    let
      loginItems = [
        "/Applications/Firefox.app"
        "/Applications/Hammerspoon.app"
        "/Applications/Rocket.app"
        "/Applications/kitty.app"
        "/Applications/Vorssaint.app"
      ];
    in
    lib.strings.concatMapStringsSep "\n" (path: ''
      osascript -e '
        tell application "System Events" to make login item at end with properties { name: "${path}", path: "${path}", hidden: true }
      '
    '') loginItems;

  imports = [
    ./rocket.nix
    ./system-preferences.nix
  ];
}
