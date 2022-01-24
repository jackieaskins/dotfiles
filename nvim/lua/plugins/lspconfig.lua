-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local servers = require('lsp.servers').server_names
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { 'ls_emmet', '--stdio' },
      filetypes = {
        'css',
        'html',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'xml',
      },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end

for _, server in ipairs(servers) do
  local base_config = require('lsp.base_config')()

  local ok, config_func = pcall(require, 'lsp.config.' .. server)
  local config = ok and config_func(base_config) or base_config

  lspconfig[server].setup(config)
end
