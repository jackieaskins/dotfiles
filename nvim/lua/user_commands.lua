local utils = require('utils')
local open_url, user_command = utils.open_url, utils.user_command

-- Neoformat
local function neoformat()
  return require('plugins.neoformat')
end

user_command('FormatterUpdateAll', function()
  neoformat().update_formatters(vim.tbl_keys(neoformat().formatters))
end)
user_command('FormatterUpdate', function(arg)
  local formatter_names = arg.args ~= '' and vim.split(arg.args, ' ')
    or { neoformat().formatter_by_filetype[vim.bo.filetype].name }
  neoformat().update_formatters(formatter_names)
end, {
  nargs = '*',
  complete = function()
    return vim.tbl_keys(neoformat().formatters)
  end,
})

-- Nvim-Lint
local function lint()
  return require('plugins.lint')
end

user_command('LinterUpdateAll', function()
  lint().update_linters(vim.tbl_keys(lint().linters))
end)
user_command('LinterUpdate', function(arg)
  local linter_names = arg.args ~= '' and vim.split(arg.args, ' ') or lint().linters_by_filetype[vim.bo.filetype]
  lint().update_linters(linter_names)
end, {
  nargs = '*',
  complete = function()
    return vim.tbl_keys(lint().linters)
  end,
})

-- LSP
user_command('LspUpdateAll', function()
  require('lsp.update').update_all_servers()
end)
user_command('LspUpdate', function(arg)
  require('lsp.update').update_servers(arg.args)
end, {
  nargs = '*',
  complete = function()
    return require('lsp.servers').server_names
  end,
})

-- Terminal
user_command('T', 'botright split | terminal <args>', { nargs = '*' })
user_command('VT', 'botright vsplit | terminal <args>', { nargs = '*' })

-- Dotfiles
user_command('Dotfiles', function()
  local dotfiles_repo = 'https://github.com/jackieaskins/dotfiles'
  local dotfiles_path = vim.fn.getenv('HOME') .. '/dotfiles'
  local cwd = vim.fn.getcwd()

  if dotfiles_path == cwd then
    local file_path = vim.split(vim.fn.expand('%'), cwd)[1]
    if file_path ~= '' then
      return open_url(dotfiles_repo .. '/blob/main/' .. file_path)
    end
  end

  open_url(dotfiles_repo)
end)
