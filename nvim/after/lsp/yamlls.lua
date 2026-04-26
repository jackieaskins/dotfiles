---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.yamlls
  settings = {
    yaml = {
      schemaStore = {
        -- Must be disabled for schemastore.nvim
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      -- https://www.schemastore.org
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
