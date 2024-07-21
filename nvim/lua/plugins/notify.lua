return {
  'rcarriga/nvim-notify',
  config = function()
    local icons = require('diagnostic.icons')

    ---@diagnostic disable-next-line: missing-fields
    require('notify').setup({
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = vim.g.border_style })
      end,
      timeout = 2500,
      icons = {
        ERROR = icons.ERROR,
        INFO = icons.INFO,
        WARN = icons.WARN,
      },
    })
    vim.notify = require('notify')
  end,
}
