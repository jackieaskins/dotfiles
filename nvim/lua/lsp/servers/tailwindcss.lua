---@type LspServer
return {
  display = 'tailwind',
  config = function(config)
    config.root_dir = require('lspconfig').util.root_pattern('tailwind.config.*', 'node_modules/tailwindcss')

    return config
  end,
  install = { 'npm', '@tailwindcss/language-server' },
}
