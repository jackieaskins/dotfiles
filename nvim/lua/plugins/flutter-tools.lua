require('flutter-tools').setup({
  closing_tags = {
    highlight = 'Whitespace',
  },
  dev_log = { open_cmd = 'tabedit' },
  lsp = require('lsp.base_config')(),
})

require('telescope').load_extension('flutter')
require('utils').map('n', '<leader>ft', '<cmd>Telescope flutter commands<CR>')
