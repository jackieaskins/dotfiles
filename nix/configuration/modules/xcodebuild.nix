{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.coreutils
    pkgs.xcbeautify
    pkgs.python314Packages.pymobiledevice3
  ];

  homebrew.brews = [
    "swiftformat"
    "xcode-build-server"
    "xcp"
  ];
}
