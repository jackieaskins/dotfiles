{ ... }: {
  homebrew.casks = [ "vorssaint" ];

  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable 'Cmd + Space' for Spotlight
        "64".enabled = false;
      };
    };
  };
}
