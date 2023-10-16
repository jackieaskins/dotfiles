---@type LspServer
return {
  display = 'tailwind',
  config = function(config)
    config.on_attach = function(_, bufnr)
      require('telescope').load_extension('tailiscope')
      require('utils').buffer_map(bufnr)('n', '<leader>tw', '<cmd>Telescope tailiscope<CR>')
    end
    config.root_dir = require('lspconfig').util.root_pattern('tailwind.config.*', 'node_modules/tailwindcss')

    return config
  end,
  install = { 'npm', '@tailwindcss/language-server' },
}
