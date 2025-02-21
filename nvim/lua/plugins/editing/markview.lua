---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  ---@module 'markview'
  ---@type mkv.config
  opts = {
    preview = {
      hybrid_modes = { 'n', 'no', 'c' },
    },
  },
}
