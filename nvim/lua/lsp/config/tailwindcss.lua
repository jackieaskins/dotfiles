return function(config)
  config.root_dir = require('lspconfig').util.root_pattern(
    'tailwind.config.js',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.ts',
    'node_modules/tailwindcss'
  )

  return config
end
