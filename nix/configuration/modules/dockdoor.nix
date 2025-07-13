{ ... }:
{
  homebrew.casks = [ "dockdoor" ];

  system.defaults.CustomUserPreferences = {
    "com.ethanbills.DockDoor" = {
      showAppName = 0;
      enabledTrafficLightButtons = [
        "quit"
        "close"
        "minimize"
        "toggleFullScreen"
        "openNewWindow"
      ];
    };
  };
}
