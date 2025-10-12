# https://devenv.sh/reference/options/
{ inputs, pkgs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  languages.lua = {
    enable = true;
    package = pkgs.lua51Packages.lua;
  };

  git-hooks.hooks = {
    commitizen = {
      enable = true;
      package = pkgs-unstable.commitizen;
    };
    nixfmt-rfc-style.enable = true;
    stylua.enable = true;
  };
}
