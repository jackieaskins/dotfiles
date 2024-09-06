---@type LazySpec
return {
  'chrishrb/gx.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { 'gx', '<cmd>Browse<CR>', mode = { 'n', 'x' }, desc = 'Open URL under cursor' },
  },
  cmd = 'Browse',
  init = function()
    vim.g.netrw_nogx = 1
  end,
  ---@module 'gx'
  ---@type GxOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    handlers = vim.tbl_extend('force', {
      search = false,
      tmux = {
        name = 'tmux',
        filetype = { 'tmux' },
        handle = function(mode, line, _)
          local plugin = require('gx.helper').find(line, mode, '["\']([^%s~/]*/[^%s~/]*)["\']')

          if plugin then
            return 'https://github.com/' .. plugin
          end
        end,
      },
    }, vim.g.custom_gx_handlers),
  },
}
