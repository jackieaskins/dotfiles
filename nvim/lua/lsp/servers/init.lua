-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local M = {}

local all_servers = {
  diagnosticls = require'lsp/servers/diagnosticls'.configure,
  jdtls = require'lsp/servers/jdtls'.configure,
  jsonls = false,
  pyright = false,
  solargraph = false,
  sumneko_lua = require'lsp/servers/sumneko_lua'.configure,
  vimls = false,
  tsserver = false
}

function M.setup_servers()
  local lspconfig = require'lspconfig'

  for server, config_func in pairs(all_servers) do
    local base_config = {
      capabilities = require'lsp/capabilities',
      on_attach = require'lsp/attach'.custom_attach
    }

    local config = config_func and config_func(base_config) or base_config

    lspconfig[server].setup(config)
  end
end

return M
