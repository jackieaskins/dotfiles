{ pkgs, ... }:
{
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  system.defaults = {
    NSGlobalDomain = {
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
            "/System/Applications/Notes.app"
            "/System/Applications/Messages.app"
            "/Applications/Safari.app"
            "/System/Applications/Utilities/Terminal.app"
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
    (pkgs.nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];
}
