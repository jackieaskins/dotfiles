return {
  config = function(config)
    config.on_attach = function(...)
      require('lsp.attach')(...)
      require('telescope').load_extension('tailiscope')
      require('utils').map('n', '<leader>tw', '<cmd>Telescope tailiscope<CR>')
    end
    config.root_dir = require('lspconfig').util.root_pattern(
      'tailwind.config.js',
      'tailwind.config.ts',
      'postcss.config.js',
      'postcss.config.ts',
      'node_modules/tailwindcss'
    )

    return config
  end,
  install = { 'npm', '@tailwindcss/language-server' },
}
