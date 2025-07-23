---@type LazySpec
return {
  'AckslD/messages.nvim',
  enabled = not MY_CONFIG.experimental_ui,
  cmd = 'Messages',
  opts = function()
    local buffer_opts = require('messages.config').settings.buffer_opts

    return {
      buffer_opts = function(lines)
        return vim.tbl_extend('force', buffer_opts(lines), {
          border = MY_CONFIG.border_style,
        })
      end,
    }
  end,
}
