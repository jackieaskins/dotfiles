local flake_path = vim.fn.expand('~/dotfiles/nix')
local flake = '(builtins.getFlake "' .. flake_path .. '")'
local flake_base = flake .. '.darwinConfigurations."Jackies-MacBook-Pro".options'

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      options = {
        nix_darwin = { expr = flake_base },
        home_manager = {
          expr = flake .. '.homeConfigurations.jackie.options',
        },
        nix_homebrew = {
          expr = flake_base .. '.nix-homebrew.user.type.getSubOptions []',
        },
      },
    },
  },
}
