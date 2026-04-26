{ ... }:
{
  # Another update another broken package :)
  # https://github.com/NixOS/nixpkgs/issues/507531
  # https://github.com/NixOS/nixpkgs/issues/513019
  nixpkgs.overlays = [
    (_final: _super: {
      direnv = _super.direnv.overrideAttrs (_: {
        doCheck = false;
      });
    })
  ];
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
