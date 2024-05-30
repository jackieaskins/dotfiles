local utils = require('utils')
local open_url, user_command = utils.open_url, utils.user_command

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

-- File Writes
user_command('W', function()
  vim.notify('Saving since you probably meant :w')
  vim.cmd.write()
end)
