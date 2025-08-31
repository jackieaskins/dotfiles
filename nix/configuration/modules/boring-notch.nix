{ ... }:
{
  homebrew = {
    taps = [ "TheBoredTeam/boring-notch" ];
    casks = [ "boring-notch" ];
  };

  system.defaults.CustomUserPreferences = {
    "theboringteam.boringnotch" = {
      SUAutomaticallyUpdate = 0;
      SUEnableAutomaticChecks = 1;
      SUSendProfileInfo = 0;
      closeGestureEnabled = 0;
      enableSneakPeek = 1;
      extendHoverArea = 0;
      mediaController = "Now Playing";
      menubarIcon = 1;
      musicLiveActivity = 1;
      showBatteryIndicator = 0;
      showOnAllDisplays = 1;
      showShuffleAndRepeat = 1;
      waitInterval = 5;
    };
  };
}
