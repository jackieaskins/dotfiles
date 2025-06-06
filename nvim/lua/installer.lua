---@alias InstallCommand string[] | fun(install_dir?:string):string[]

local utils = require('utils')

local pkg_managers = {
  brew = 'brew reinstall %s',
  cargo = 'cargo install %s',
  gem = 'gem install --user-install %s',
  go = 'go install %s',
  npm = 'npm install -g %s',
  pip = 'uv tool install --upgrade %s',
}

---@class RegisteredCommands
---@field commands table<string, InstallCommand>
---@field install_dir? string

---@type table<string, RegisteredCommands>
local registered_commands = {}

local M = {}

---@param group_name string
local function create_group_user_command(group_name)
  local capitalized_group_name = group_name:gsub('^%l', string.upper)

  local user_command_names = {
    'Install' .. capitalized_group_name,
    capitalized_group_name .. 'Install',
  }

  for _, user_command_name in ipairs(user_command_names) do
    local group = registered_commands[group_name]

    utils.user_command(user_command_name, function(arg)
      local cmd_keys = arg.fargs

      M.install({
        {
          group_name = group_name,
          commands = #cmd_keys > 0 and utils.filter_table_by_keys(group.commands, cmd_keys) or group.commands,
          install_dir = group.install_dir,
        },
      })
    end, {
      nargs = '*',
      complete = function()
        return vim.tbl_keys(group.commands)
      end,
    })
  end
end

---Get an install function to install the latest release from GitHub
---@param username string
---@param repo string
---@param zip_file string
---@return fun(install_path: string): string[]
function M.github_install(username, repo, zip_file)
  return function(install_path)
    local install_dir = install_path .. '/' .. repo

    return {
      'rm -rf ' .. install_dir,
      'mkdir ' .. install_dir,
      string.format('wget https://github.com/%s/%s/releases/latest/download/%s', username, repo, zip_file),
      string.format('tar -xf %s -C %s', zip_file, install_dir),
      'rm ' .. zip_file,
    }
  end
end

---Register install group with installation directory and commands
---@param group_name string
---@param commands table<string, InstallCommand>
---@param install_dir? string
function M.register(group_name, commands, install_dir)
  if vim.tbl_isempty(commands) then
    return
  end

  registered_commands[group_name] = {
    commands = commands,
    install_dir = install_dir,
  }

  create_group_user_command(group_name)
end

---Add an additional command to an existing install group
---@param group_name string
---@param command_key string
---@param command InstallCommand
function M.extend(group_name, command_key, command)
  registered_commands[group_name].commands[command_key] = command
end

---@class InstallGroup: RegisteredCommands
---@field group_name string

---Generic install command
---@param groups InstallGroup[]
function M.install(groups)
  local script_lines = {}

  for _, group in ipairs(groups) do
    local group_name, commands, install_dir = group.group_name, group.commands, group.install_dir

    ---@type table<string, string[]>
    local common_packages = {}

    local function echo(text)
      table.insert(script_lines, string.format('echo "%s"', text))
    end

    echo('[' .. group_name .. '] Starting installation\n')

    for name, command in pairs(commands) do
      if type(command) == 'function' then
        echo('Installing ' .. name)
        if install_dir then
          table.insert(script_lines, 'cd ' .. install_dir)
        end

        for _, line in ipairs(command(install_dir)) do
          table.insert(script_lines, line)
        end

        if install_dir then
          table.insert(script_lines, 'cd ' .. install_dir)
        end
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
      local cmd_install = pkg_managers[cmd]:gsub('%%s', packages)
      table.insert(script_lines, cmd_install)
      echo('')
    end

    if install_dir then
      os.execute('mkdir -p ' .. install_dir)
    end
  end

  vim.cmd.new()
  vim.cmd.startinsert()

  vim.fn.jobstart({ 'sh', '-c', table.concat(script_lines, '\n') }, { term = true })
end

utils.user_command('InstallAll', function()
  ---@type InstallGroup[]
  local all_groups = {}

  for group_name, group in pairs(registered_commands) do
    table.insert(all_groups, {
      group_name = group_name,
      commands = group.commands,
      install_dir = group.install_dir,
    })
  end

  M.install(all_groups)
end)

return M
