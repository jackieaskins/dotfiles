return {
  'rhysd/committia.vim',
  config = function()
    local map = require('utils').map

    vim.g.committia_hooks = {
      edit_open = function()
        map({ 'i', 'n' }, '<C-d>', '<Plug>(committia-scroll-diff-down-half)', { buffer = 0 })
        map({ 'i', 'n' }, '<C-u>', '<Plug>(committia-scroll-diff-up-half)', { buffer = 0 })
        map({ 'i', 'n' }, '<C-f>', '<Plug>(committia-scroll-diff-down-page)', { buffer = 0 })
        map({ 'i', 'n' }, '<C-b>', '<Plug>(committia-scroll-diff-up-page)', { buffer = 0 })
        map({ 'i', 'n' }, '<C-e>', '<Plug>(committia-scroll-diff-down)', { buffer = 0 })
        map({ 'i', 'n' }, '<C-y>', '<Plug>(committia-scroll-diff-up)', { buffer = 0 })
      end,
    }
  end,
}
