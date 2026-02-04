---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
  keys = {
    { '<leader>mv', '<cmd>Markview toggle<CR>' },
  },
  config = function()
    require('markview').setup()
  end,
}
