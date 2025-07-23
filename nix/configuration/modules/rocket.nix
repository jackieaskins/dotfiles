{ ... }:
{
  homebrew.casks = [ "rocket" ];

  system.defaults.CustomUserPreferences = {
    "net.matthewpalmer.Rocket" = {
      launch-at-login = 1;
      preemptive-apple-event-access = 0; # Don't allow Rocket to check websites
      preferred-skin-tone = 16;
      use-double-trigger = 1;
    };
  };
}
