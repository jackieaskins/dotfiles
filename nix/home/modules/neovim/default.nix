{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  getAttrsWithPkgs =
    filepath:
    lib.attrsets.filterAttrs (name: value: (lib.hasAttrByPath [ "pkgs" ] value)) (
      lib.importJSON filepath
    );

  getPkgNames =
    attrs: lib.lists.flatten (lib.attrsets.mapAttrsToList (name: value: value.pkgs) attrs);

  getPkgsFromJsonFile =
    filepath: lib.lists.map (value: pkgs.${value}) (getPkgNames (getAttrsWithPkgs filepath));
in
{
  home.packages =
    [
      inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
      pkgs.tree-sitter
    ]
    ++ (getPkgsFromJsonFile ./lsp-servers.json)
    ++ (getPkgsFromJsonFile ./formatters.json);

  home.file = {
    ".config/nvim".source = config.lib.custom.mkDotfilesSymlink "nvim";
    ".config/wezterm".source = config.lib.custom.mkDotfilesSymlink "wezterm";
    "dotfiles/nvim/lua/custom.lua".source = config.lib.custom.mkCustomSymlink "nvim.lua";
  };
}
