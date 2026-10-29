local flake_path = vim.fn.expand('~/dotfiles/nix')
local flake = '(builtins.getFlake "' .. flake_path .. '")'

local home_manager_base = flake .. '.homeConfigurations."' .. vim.env.USER .. '".options'
local darwin_base = flake .. '.darwinConfigurations."' .. vim.uv.os_gethostname() .. '".options'

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.nixd
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      options = {
        nix_darwin = { expr = darwin_base },
        home_manager = { expr = home_manager_base },
        nix_homebrew = {
          expr = darwin_base .. '.nix-homebrew.user.type.getSubOptions []',
        },
        nix_plist_manager = { expr = home_manager_base .. '.programs.nix-plist-manager.options' },
      },
    },
  },
}
