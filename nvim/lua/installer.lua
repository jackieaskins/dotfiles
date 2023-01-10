local utils = require('utils')
local filter_table_by_keys, user_command = utils.filter_table_by_keys, utils.user_command

local M = {}

local pkg_managers = {
  brew = 'brew reinstall',
  cargo = 'cargo install',
  gem = 'gem install --user-install',
  go = 'go install',
  npm = 'npm install -g',
  pip3 = 'pip3 install',
}

---Register install group with installation directory and commands
---@param group_name string
---@param commands table<string, string[] | fun(install_dir?:string):table>
---@param install_dir string
function M.register(group_name, commands, install_dir)
  user_command(group_name:gsub('^%l', string.upper) .. 'Install', function(arg)
    local cmd_keys = arg.fargs

    if #cmd_keys > 0 then
      M.install(filter_table_by_keys(commands, cmd_keys), install_dir)
    else
      M.install(commands, install_dir)
    end
  end, {
    nargs = '*',
    complete = function()
      return vim.tbl_keys(commands)
    end,
  })
end

---Generic install command
---@param command_map table<string, string[] | fun(install_dir?:string):table>
---@param install_dir? string
function M.install(command_map, install_dir)
  local script_lines = {}
  local common_packages = {}

  local function echo(text)
    table.insert(script_lines, string.format('echo "%s"', text))
  end

  for name, command in pairs(command_map) do
    if type(command) == 'function' then
      echo('Installing ' .. name)
      for _, line in ipairs(command(install_dir)) do
        table.insert(script_lines, line)
      end
      table.insert(script_lines, 'cd ' .. install_dir)
      echo('')
    elseif pkg_managers[command[1]] ~= nil then
      local install = common_packages[command[1]] or {}
      install[name] = command[2]
      common_packages[command[1]] = install
    else
      print('Invalid update function for ' .. name)
    end
  end

  for cmd, info in pairs(common_packages) do
    local names = table.concat(vim.tbl_keys(info), ', ')

    local unique_packages = {}
    for _, package in pairs(info) do
      unique_packages[package] = true
    end
    local packages = table.concat(vim.tbl_keys(unique_packages), ' ')

    echo(string.format('[%s] Installing packages for %s', cmd, names))
    table.insert(script_lines, pkg_managers[cmd] .. ' ' .. packages)
    echo('')
  end

  local script = table.concat(script_lines, '\n')

  os.execute('mkdir -p ' .. install_dir)
  vim.cmd.new()
  vim.cmd.startinsert()
  vim.fn.termopen({ 'sh', '-c', script }, { cwd = install_dir })
end

return M
