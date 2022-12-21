return {
  'Wansmer/treesj',
  cmd = { 'TSJJoin', 'TSJSplit' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      langs = {
        jsonc = require('treesj.langs.json'),
      },
    })
  end,
  init = function()
    local map = require('utils').map

    map('n', 'gJ', vim.cmd.TSJJoin)
    map('n', 'gS', vim.cmd.TSJSplit)
  end,
}
