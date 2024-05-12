return {
  'nvim-zh/colorful-winsep.nvim',
  event = 'WinNew',
  config = function()
    require('colorful-winsep').setup()
    require('utils').augroup('colorful_winsep_mode', {
      {
        'ModeChanged',
        callback = function()
          vim.api.nvim_set_hl(0, 'NvimSeparator', { fg = require('modes').get_color() })
        end,
      },
    })
  end,
}
