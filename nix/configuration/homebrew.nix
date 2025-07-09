{ ... }:
{
  homebrew = {
    enable = true;

    casks = [
      "alcove"
      "dockdoor"
      "firefox"
      "hammerspoon"
      "karabiner-elements"
      "raycast"
      "rocket"
      "sanesidebuttons"
      "sf-symbols"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
