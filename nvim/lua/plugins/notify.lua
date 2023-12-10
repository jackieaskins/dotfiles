return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = vim.g.border_style })
      end,
      timeout = 3000,
    })
    vim.notify = require('notify')
  end,
}
