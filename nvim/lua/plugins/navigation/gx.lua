return {
  'chrishrb/gx.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { 'gx', '<cmd>Browse<CR>', mode = { 'n', 'x' } },
  },
  cmd = 'Browse',
  init = function()
    vim.g.netrw_nogx = 1
  end,
  opts = {
    handlers = {
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
    },
  },
}
