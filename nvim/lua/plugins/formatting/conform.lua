---@type LazySpec
return {
  'stevearc/conform.nvim',
  lazy = true,
  config = function()
    require('conform').setup({ undojoin = true })
  end,
  init = function()
    local utils = require('utils')
    local formatting_utils = require('formatting')

    utils.augroup('conform', {
      {
        'BufWritePre',
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          local formatters = formatting_utils.get_active_formatters(filetype)
          if #formatters > 0 then
            require('conform').format({ formatters = formatters })
          end
        end,
      },
    })

    utils.user_command('Format', function()
      local formatters = formatting_utils.get_formatters(vim.bo.filetype)

      if #formatters > 0 then
        require('conform').format({ formatters = formatters })
      else
        vim.notify('No formatter defined for filetype', vim.log.levels.ERROR)
      end
    end)
  end,
}
