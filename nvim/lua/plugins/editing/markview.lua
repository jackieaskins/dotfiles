---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  keys = {
    { '<leader>mv', '<cmd>Markview toggle<CR>' },
  },
  ft = 'markdown',
  keys = {
    { '<leader>mv', '<cmd>Markview toggle<CR>' },
  },
  ---@module 'markview'
  ---@type mkv.config
  opts = {},
}
