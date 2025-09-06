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

-- Alternate Files
for key, cmd in pairs({
  D = 'drop',
  E = 'edit',
  S = 'split',
  V = 'vsplit',
  T = 'tabedit',
}) do
  user_command(key, function(arg)
    require('alternate_files').try_open_alternate(cmd, arg.args)
  end, {
    nargs = 1,
    complete = function()
      return require('alternate_files').get_alternate_types()
    end,
  })
end

-- Toggles
local toggles = {
  { name = 'ToggleArrowFunctionBraces', file = 'toggles.arrow_function_braces' },
  { name = 'ToggleStringInterpolation', file = 'toggles.string_interpolation' },
}

for _, toggle in ipairs(toggles) do
  user_command(toggle.name, function()
    require(toggle.file).toggle()
  end)
end

-- Nix
user_command('NixSwitch', function()
  require('runner').run_command('nix-switch')
end)
user_command('NixUpdate', function()
  require('runner').run_command('nix-update')
end)
user_command('NixGC', function()
  require('runner').run_command('nix-collect-garbage -d && sudo nix-collect-garbage -d')
end)

-- Utils
user_command('JQ', '%!jq .')
