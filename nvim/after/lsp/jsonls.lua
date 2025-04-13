---@type vim.lsp.Config
return {
  settings = {
    json = {
      -- https://www.schemastore.org
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
