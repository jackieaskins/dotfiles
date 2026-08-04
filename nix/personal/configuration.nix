{ config, pkgs, ... }:
let
  homeDirectory = config.users.users.${config.system.primaryUser}.home;
in
{
  environment.systemPackages = [
    pkgs.mas
    pkgs.qmk
  ];

  homebrew.casks = [
    "discord"
    "iina"
    "keycastr"
    "logitune"
    "logitech-g-hub"
    "virtualbuddy"
    "whatsapp"
  ];

  system.defaults.dock.persistent-apps = [
    "/System/Applications/Apps.app"
    "/System/Applications/Notes.app"
    "/System/Applications/FaceTime.app"
    "/Applications/WhatsApp.app"
    "/System/Applications/Messages.app"
    "/System/Applications/Music.app"
    "${homeDirectory}/Applications/Home Manager Apps/kitty.app"
    "/Applications/Firefox.app"
  ];
}
