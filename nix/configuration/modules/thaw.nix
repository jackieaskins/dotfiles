{ ... }:
{
  homebrew.casks = [ "thaw" ];

  system.defaults.CustomUserPreferences = {
    "com.stonerl.Thaw" = {
      ShowOnClick = 0;
      ShowOnScroll = 0;
      UseIceBar = 1;
    };
  };
}
