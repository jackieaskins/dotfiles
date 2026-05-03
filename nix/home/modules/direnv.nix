{ ... }:
{
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
