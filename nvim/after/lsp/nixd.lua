local flake_path = vim.fn.expand('~/dotfiles/nix')
local flake = '(builtins.getFlake "' .. flake_path .. '")'
local hostname = vim.fn.system('hostname -s')

---@type vim.lsp.Config
return {
  settings = {
    nixd = {
      options = {
        home_manager = {
          expr = flake .. '.homeConfigurations.' .. vim.env.USER .. '.options',
        },
        nix_darwin = {
          expr = flake .. '.darwinConfigurations.' .. hostname .. '.options',
        },
      },
    },
  },
}
