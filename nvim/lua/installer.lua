local M = {}

---Generic install command
---@param command_map table<string, string[] | fun(install_dir?:string)>
---@param install_dir? string
function M.install(command_map, install_dir)
  local script_lines = {}
  local generic_installs = {
    brew = { cmd = 'brew reinstall', names = {}, packages = {} },
    cargo = { cmd = 'cargo install', names = {}, packages = {} },
    gem = { cmd = 'gem install --user-install', names = {}, packages = {} },
    go = { cmd = 'go install', names = {}, packages = {} },
    npm = { cmd = 'npm install -g', names = {}, packages = {} },
  }

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
    elseif generic_installs[command[1]] ~= nil then
      local install = generic_installs[command[1]]

      table.insert(install.names, name)
      table.insert(install.packages, command[2])
    else
      print('Invalid update function for ' .. name)
    end
  end

  for _, info in pairs(generic_installs) do
    if not vim.tbl_isempty(info.packages) then
      echo(string.format('echo "Installing packages for %s"', table.concat(info.names, ', ')))
      table.insert(script_lines, string.format('%s %s', info.cmd, table.concat(info.packages, ' ')))
      echo('')
    end
  end

  local script = table.concat(script_lines, '\n')

  os.execute('mkdir -p ' .. install_dir)
  vim.cmd('new | startinsert')
  vim.fn.termopen({ 'sh', '-c', script }, { cwd = install_dir })
end

return M
