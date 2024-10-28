---@diagnostic disable: missing-fields
---@type LazySpec
return {
  'OXY2DEV/markview.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  ---@module 'markview'
  ---@type markview.configuration
  opts = {
    initial_state = false,
    code_blocks = { icons = 'mini', pad_amount = 2 },
  },
}
