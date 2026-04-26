---@type LazySpec
return {
  'numToStr/Navigator.nvim',
  cond = vim.env.TMUX or vim.env.TERM ~= 'xterm-kitty',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('Navigator').setup({})
  end,
  keys = {
    { '<C-h>', '<cmd>NavigatorLeft<CR>', mode = { 'n', 't' } },
    { '<C-l>', '<cmd>NavigatorRight<CR>', mode = { 'n', 't' } },
    { '<C-k>', '<cmd>NavigatorUp<CR>', mode = { 'n', 't' } },
    { '<C-j>', '<cmd>NavigatorDown<CR>', mode = { 'n', 't' } },
  },
}
