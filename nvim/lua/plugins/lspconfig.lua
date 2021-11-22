-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local servers = require('lsp.servers')
local lspconfig = require('lspconfig')

for _, server in ipairs(servers) do
  local base_config = require('lsp.base_config')()

  local ok, config_func = pcall(require, 'lsp.config.' .. server)
  local config = ok and config_func(base_config) or base_config

  lspconfig[server].setup(config)
end
