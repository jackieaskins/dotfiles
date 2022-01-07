local user_command = require('utils').user_command

-- Formatter
local function formatter()
  return require('plugins.formatter')
end

user_command('FormatterUpdateAll', function()
  formatter().update_formatters(vim.tbl_keys(formatter().formatters))
end)
user_command('FormatterUpdate', function()
  local formatter_names = arg.args and vim.split(arg.args, ' ')
    or { formatter().formatter_by_filetype[vim.bo.filetype].name }
  formatter().update_formatters(formatter_names)
end, {
  nargs = '+',
  complete = function()
    return vim.tbl_keys(formatter().formatters)
  end,
})

-- LSP
user_command('LspLog', 'vsplit ~/.cache/nvim/lsp.log')
user_command('LspUpdateAll', function()
  require('lsp.update').update_all_servers()
end)
user_command('LspUpdate', function(arg)
  require('lsp.update').update_servers(arg.args)
end, {
  nargs = '+',
  complete = function()
    return require('lsp.servers').server_names
  end,
})

-- Terminal
user_command('T', 'botright split | terminal <args>', { nargs = '*' })
user_command('VT', 'botright vsplit | terminal <args>', { nargs = '*' })
