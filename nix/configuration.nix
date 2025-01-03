{ pkgs, ... }:
{
  system.stateVersion = 5;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  environment.systemPackages = [
    pkgs.iina
    pkgs.mas
    pkgs.qmk
  ];

  services.jankyborders = {
    enable = true;
    active_color = "0xFFA6DA95";
    width = 8.0;
    hidpi = true;
    inactive_color = "";
  };

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "ghostty"
      "hammerspoon"
      "jordanbaird-ice"
      "karabiner-elements"
      "raycast"
      "sf-symbols"
      "zen-browser"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "WhenScrolling";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      magnification = true;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Applications/Notes.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Music.app"
        "/Applications/Zen Browser.app"
        "/Applications/Ghostty.app"
        "/System/Applications/Passwords.app"
      ];
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    loginwindow.GuestEnabled = false;

    menuExtraClock = {
      ShowAMPM = true;
      ShowDate = 1;
      ShowDayOfWeek = false;
      ShowSeconds = true;
    };

    spaces.spans-displays = false;

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.mononoki
  ];
}