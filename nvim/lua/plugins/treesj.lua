return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = function()
    return {
      use_default_keymaps = false,
      langs = {
        jsonc = require('treesj.langs.json'),
      },
      max_join_length = math.huge,
    }
  end,
  keys = {
    { 'gJ', vim.cmd.TSJJoin, desc = 'TSJJoin' },
    { 'gS', vim.cmd.TSJSplit, desc = 'TSJSplit' },
  },
}
