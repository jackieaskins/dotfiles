local map = require('utils').map

return {
  'numToStr/Navigator.nvim',
  config = true,
  init = function()
    map({ 'n', 't' }, '<C-h>', '<cmd>NavigatorLeft<CR>')
    map({ 'n', 't' }, '<C-l>', '<cmd>NavigatorRight<CR>')
    map({ 'n', 't' }, '<C-k>', '<cmd>NavigatorUp<CR>')
    map({ 'n', 't' }, '<C-j>', '<cmd>NavigatorDown<CR>')
    map({ 'n', 't' }, '<C-\\>', '<cmd>NavigatorPrevious<CR>')
  end,
}
