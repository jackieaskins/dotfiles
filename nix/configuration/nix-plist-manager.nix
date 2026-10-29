{ ... }:
{
  programs.nix-plist-manager = {
    enable = true;
    options.applications = {
      systemSettings = {
        battery = {
          options = {
            preventAutomaticSleepingOnPowerAdapterWhenTheDisplayIsOff = false;
            slightlyDimTheDisplayOnBattery = true;
            wakeForNetworkAccess = "Only on Power Adapter";
          };
        };

        general = {
          softwareUpdate = {
            automaticallyDownloadNewUpdatesWhenAvailable = true;
            automaticallyInstallApplicationUpdatesFromTheAppStore = true;
            automaticallyInstallMacOSUpdates = true;
            automaticallyInstallSystemDataFilesAndSecurityUpdates = true;
          };

          dateAndTime = {
            setTimeZoneAutomaticallyUsingYourCurrentLocation = true;
          };
        };

        lockScreen = {
          turnDisplayOffOnBatteryWhenInactive = "For 5 minutes";
          turnDisplayOffOnPowerAdapterWhenInactive = "For 10 minutes";
        };

        privacyAndSecurity = {
          analyticsAndImprovements = {
            shareMacAnalytics = false;
            shareWithAppDevelopers = false;
          };
        };

        network = {
          firewall = {
            firewall = true;
          };
        };
      };
    };
  };
}
