---@type LspServer
return {
  config = function(config)
    config.settings = {
      json = {
        -- https://www.schemastore.org
        schemas = {
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'jsconfig*.json' },
            url = 'https://json.schemastore.org/jsconfig.json',
          },
          {
            fileMatch = { 'tsconfig*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
        },
      },
    }

    return config
  end,
  install = { 'npm', 'vscode-langservers-extracted' },
}
