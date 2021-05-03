local M = {}

function M.configure(config)
  config.settings = {
    json = {
      -- https://www.schemastore.org
      schemas = {
        {
          fileMatch = {'.babelrc', '.babelrc.json', 'babel.config.json'},
          url = 'https://json.schemastore.org/babelrc.json',
        },
        {
          fileMatch = {'package.json'},
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = {'tsconfig*.json'},
          url = 'https://json.schemastore.org/tsconfig.json'
        }
      }
    }
  }
  return config
end

return M
