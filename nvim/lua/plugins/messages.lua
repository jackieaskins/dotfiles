return {
  'AckslD/messages.nvim',
  cmd = 'Messages',
  opts = function()
    local buffer_opts = require('messages.config').settings.buffer_opts

    return {
      buffer_opts = function(lines)
        return vim.tbl_extend('force', buffer_opts(lines), {
          border = vim.g.border_style,
        })
      end,
    }
  end,
}
