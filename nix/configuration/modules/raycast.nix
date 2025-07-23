{ ... }:
{
  homebrew.casks = [ "raycast" ];

  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable 'Cmd + Space' for Spotlight
        "64" = {
          enabled = false;
        };
      };
    };

    "com.raycast.macos" = {
      emojiPicker_skinTone = "mediumDark";
      hasShownStatusBarHintAfterOnboarding = 1;
      onboardingCompleted = 1;
      popToRootTimeout = 15;
      raycastGlobalHotkey = "Command-49";
      showGettingStartedLink = 0;
    };
  };
}
