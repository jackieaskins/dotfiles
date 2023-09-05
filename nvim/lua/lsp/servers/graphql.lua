---@type LspServer
return {
  config = function(config)
    config.filetypes = { 'graphql' }
    return config
  end,
  install = { 'npm', 'graphql-language-service-cli' },
}
