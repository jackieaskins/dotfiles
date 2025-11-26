# https://devenv.sh/reference/options/
{ pkgs, ... }:
{
  languages.lua = {
    enable = true;
    package = pkgs.lua51Packages.lua;
  };

  git-hooks.hooks = {
    commitizen.enable = true;
    nixfmt-rfc-style.enable = true;
    stylua.enable = true;
  };
}
