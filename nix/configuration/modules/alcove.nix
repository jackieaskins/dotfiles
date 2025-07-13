{ ... }:
{
  homebrew.casks = [ "alcove" ];

  system.defaults.CustomUserPreferences = {
    "com.henrikruscon.Alcove" = {
      launchAtLogin = 1;
    };
  };
}
