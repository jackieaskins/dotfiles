---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.jsonls
  settings = {
    json = {
      -- https://www.schemastore.org
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
