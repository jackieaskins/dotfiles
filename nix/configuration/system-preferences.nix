{ config, ... }:
let
  homeDirectory = config.users.users.${config.system.primaryUser}.home;
in
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

    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable '^ + Space' for 'Select the previous input source'
          "60".enabled = false;

          # Disable '^ + Option + Space' for 'Select next source in Input menu'
          "61".enabled = false;
        };
      };
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
      persistent-apps = [
        "/System/Applications/Apps.app"
        "/System/Applications/Notes.app"
        "/System/Applications/FaceTime.app"
        "/Applications/WhatsApp.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Music.app"
        "/Applications/WezTerm.app"
        "/Applications/Firefox.app"
        "/System/Applications/Passwords.app"
      ];
      persistent-others = [
        "${homeDirectory}/Downloads"
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
