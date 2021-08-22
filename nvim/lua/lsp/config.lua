local loaded_servers = {}

return function(server)
  if vim.tbl_contains(loaded_servers, server) then
    return
  end

  table.insert(loaded_servers, server)
  local base_config = {
    capabilities = require('lsp.capabilities'),
    on_attach = require('lsp.attach'),
    flags = { debounce_text_changes = 150 },
  }

  local ok, config_func = pcall(require, 'lsp.config.' .. server)
  local config = ok and config_func(base_config) or base_config

  require('lspconfig')[server].setup(config)
end
