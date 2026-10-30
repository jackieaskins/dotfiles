{ ... }:
{
  programs.nix-plist-manager = {
    enable = true;
    options = {
      applications = {
        systemSettings = {
          appearance = {
            appearance = "Dark";
            showScrollBars = "When scrolling";
          };

          desktopAndDock = {
            dock = {
              magnification = {
                enabled = true;
              };
              automaticallyHideAndShowTheDock = {
                enabled = true;
              };
              showSuggestedAndRecentAppsInDock = false;
            };

            desktopAndStageManager = {
              showWindowsFromAnApplication = "One at a Time";
            };

            windows = {
              closeWindowsWhenQuittingAnApplication = false;
              tiledWindowsHaveMargins = true;
            };

            missionControl = {
              groupWindowsByApplication = true;
              shortcuts = {
                applicationWindows = "-";
                missionControl = "-";
                showDesktop = "-";
              };
            };

            hotCorners = {
              bottomLeft.action = "-";
              bottomRight.action = "-";
              topLeft.action = "-";
              topRight.action = "-";
            };
          };

          menuBar = {
            clock = {
              announceTheTime = {
                enable = false;
              };
              displayTheTimeWithSeconds = true;
              showAmPm = true;
              showDate = true;
              showTheDayOfTheWeek = false;
              style = "Digital";
            };

            bluetooth = true;
            batteryOptions = {
              showPercentage = true;
            };

            display = "Don't Show";
            sound = "Always Show";
            nowPlaying = "Don't Show";
            textInput = false;
          };

          appleIntelligenceAndSiri = {
            siri = {
              enable = false;
            };
          };

          spotlight = {
            helpAppleImproveSearch = false;
            searchResults = {
              iPhoneApps = false;
            };
          };

          wallpaper = {
            startScreenSaver = "Never";
          };

          privacyAndSecurity = {
            appleAdvertising = {
              personalizedAds = false;
            };
          };

          keyboard = {
            keyRepeatRate = 2;
            delayUntilRepeat = 15;
            keyboardShortcuts = {
              inputSources = {
                selectNextSourceInInputMenu = false;
                selectThePreviousInputSource = false;
              };
            };
            pressGlobeKeyTo = "Show Emoji & Symbols";
            textInput = {
              addPeriodWithDoubleSpace = true;
              capitalizeWordsAutomatically = true;
            };
            useF1F2EtcKeysAsStandardFunctionKeys = false;
          };

          trackpad = {
            pointAndClick = {
              click = "Medium";
              secondaryClick = "Click in Bottom Right Corner";
              forceClickAndHapticFeedback = false;
              tapToClick = true;
            };
            scrollAndZoom = {
              rotate = true;
              zoomInOrOut = true;
            };
          };
        };

        finder = {
          menuBar = {
            view = {
              showPathBar = true;
              showSidebar = true;
              showStatusBar = true;
            };
          };
          settings = {
            advanced = {
              showAllFilenameExtensions = true;
              whenPerformingASearch = "Search the Current Folder";
            };
          };
        };
      };
    };
  };
}
