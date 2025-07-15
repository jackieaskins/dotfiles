{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.ice-bar ];

  system.defaults.CustomUserPreferences = {
    "com.jordanbaird.Ice" = {
      ShowOnClick = 0;
      ShowOnScroll = 0;
      UseIceBar = 1;
    };
  };
}
