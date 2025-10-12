{ ... }:
{
  homebrew.casks = [
    "jordanbaird-ice@beta"
  ];

  system.defaults.CustomUserPreferences = {
    "com.jordanbaird.Ice" = {
      ShowOnClick = 0;
      ShowOnScroll = 0;
      UseIceBar = 1;
    };
  };
}
