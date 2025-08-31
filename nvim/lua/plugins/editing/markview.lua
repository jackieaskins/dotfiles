---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  enabled = false,
  lazy = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
  keys = {
    { '<leader>mv', '<cmd>Markview toggle<CR>' },
  },
  ---@module 'markview'
  ---@type markview.config
  opts = {
    experimental = { check_rtp_message = false },
  },
}
