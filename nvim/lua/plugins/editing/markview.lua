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
  opts = {},
  init = function()
    require('utils').augroup('markview', {
      {
        'FileType',
        pattern = 'markdown',
        command = 'setlocal nowrap',
      },
      {
        'FileType',
        pattern = 'markdown',
        command = 'let b:snacks_indent = v:false',
      },
    })
  end,
}
