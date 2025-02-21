---@type LazySpec
return {
  'chrishrb/gx.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'xiyaowong/link-visitor.nvim' },
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
      url = {
        name = 'url',
        handle = function(_, line, _)
          -- The default gx.nvim url pattern is too permissive
          -- The one from link-visitor.nvim is much better so use that instead
          local links = require('link-visitor.utils').find_links({ line })
          local col = vim.fn.col('.')

          if #links > 0 then
            for _, link in ipairs(links) do
              if col >= link.first and col <= link.last then
                return link.link
              end
            end
          end
        end,
      },
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
    }, MY_CONFIG.custom_gx_handlers),
  },
}
