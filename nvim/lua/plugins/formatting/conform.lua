---@class FormatterConfig
---@field required_file? string
---@field filetypes string[]

---@type LazySpec
return {
  'stevearc/conform.nvim',
  lazy = true,
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = { undojoin = true },
  init = function()
    local utils = require('utils')

    utils.augroup('conform', {
      {
        'BufWritePre',
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          local formatters = utils.get_active_formatters(filetype)
          if #formatters > 0 then
            require('conform').format({ formatters = formatters })
          end
        end,
      },
    })

    utils.user_command('Format', function()
      local formatters = utils.get_formatters(vim.bo.filetype)

      if #formatters > 0 then
        require('conform').format({ formatters = formatters })
      else
        vim.notify('No formatter defined for filetype', vim.log.levels.ERROR)
      end
    end)
  end,
}
