---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    local servers = require('lsp.servers')
    local lspconfig = require('lspconfig')
    local configs = require('lspconfig.configs')

    if not configs['ghostty-ls'] then
      configs['ghostty-ls'] = {
        default_config = {
          cmd = { vim.fn.stdpath('data') .. '/lsp-servers/ghostty/bin/ghostty-ls' },
          filetypes = { 'ghostty' },
          root_dir = lspconfig.util.root_pattern('.git'),
          settings = {},
        },
      }
    end

    for server_name, config in pairs(MY_CONFIG.additional_servers) do
      if not configs[server_name] then
        configs[server_name] = config.lspconfig
      end
    end

    for server_name, server in pairs(servers) do
      if not server.skip_lspconfig then
        local base_config = { capabilities = require('lsp.capabilities')() }
        local config = server.config and server.config(base_config) or base_config
        lspconfig[server_name].setup(config)
      end
    end
  end,
}
