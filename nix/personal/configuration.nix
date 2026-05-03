{ config, pkgs, ... }:
let
  homeDirectory = config.users.users.${config.system.primaryUser}.home;
in
{
  environment.systemPackages = [
    pkgs.discord
    pkgs.iina
    pkgs.keycastr
    pkgs.mas
    pkgs.qmk
  ];

  homebrew.casks = [
    "logitune"
    "logitech-g-hub"
    "virtualbuddy"
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
