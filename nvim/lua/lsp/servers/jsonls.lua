---@type LspServer
return {
  config = function(config)
    config.settings = {
      json = {
        -- https://www.schemastore.org
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    }

    return config
  end,
  install = { 'npm', 'vscode-langservers-extracted' },
}
