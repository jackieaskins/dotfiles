local map = require('utils').map

vim.g.committia_hooks = {
  edit_open = function()
    map({ 'i', 'n' }, '<C-d>', '<Plug>(committia-scroll-diff-down-half)', { buffer = 0 })
    map({ 'i', 'n' }, '<C-u>', '<Plug>(committia-scroll-diff-up-half)', { buffer = 0 })
  end,
}
