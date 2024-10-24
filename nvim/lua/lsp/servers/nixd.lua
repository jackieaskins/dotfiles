local flake_path = vim.fn.expand('~/dotfiles/nix')
local flake = '(builtins.getFlake "' .. flake_path .. '")'

return {
  config = function(config)
    config.settings = {
      nixd = {
        formatting = {
          command = { 'nixfmt' },
        },
        options = {
          home_manager = {
            expr = flake .. '.homeConfigurations.' .. vim.env.USER .. '.options',
          },
          nix_darwin = {
            expr = flake .. '.darwinConfigurations.personal.options',
          },
        },
      },
    }
    return config
  end,
}
