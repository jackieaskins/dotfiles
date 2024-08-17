---@type LspServer
return {
  display = 'tailwind',
  config = function(config)
    config.root_dir = require('lspconfig').util.root_pattern('tailwind.config.*', 'node_modules/tailwindcss')

    local capabilities = require('lsp.capabilities')()
    capabilities.textDocument.colorProvider = { dynamicRegistration = true }
    config.capabilities = capabilities

    return config
  end,
  install = { 'npm', '@tailwindcss/language-server' },
}
