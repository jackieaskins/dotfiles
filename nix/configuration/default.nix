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

    defaults = {
      finder = {
        AppleShowAllFiles = true;
        # “icnv” = Icon view, “Nlsv” = List view, “clmv” = Column View, “Flwv” = Gallery View
        FXPreferredViewStyle = "Nlsv";
      };

      loginwindow.GuestEnabled = false;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
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
      "vscodium"
    ];
  };

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  imports = [
    ./nix-plist-manager.nix
    ./rocket.nix
    ./vorssaint.nix
  ];
}
