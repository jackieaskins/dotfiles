---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  ft = 'markdown',
  keys = {
    { '<leader>mv', '<cmd>Markview toggle<CR>' },
  },
  ---@module 'markview'
  ---@type mkv.config
  opts = {},
}
