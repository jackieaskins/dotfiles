{ ... }:
{
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

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

    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = true;
      Sound = true;
    };

    dock = {
      appswitcher-all-displays = false;
      autohide = true;
      magnification = true;
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

    iCal = {
      "TimeZone support enabled" = true;
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
}
