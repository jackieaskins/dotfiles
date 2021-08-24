local cmd, fn = vim.cmd, vim.fn

local function update_servers(server_list)
  local generic_installs = {
    npm = { cmd = 'npm install -g', servers = {}, packages = {} },
    gem = { cmd = 'gem install --user-install', servers = {}, packages = {} },
    cargo = { cmd = 'cargo install', servers = {}, packages = {} },
  }

  local servers_dir = fn.stdpath('data') .. '/lsp-servers'
  local script_lines = {}

  local function echo(text)
    table.insert(script_lines, string.format('echo "%s"', text))
  end

  local function handle_install(server, update)
    if type(update) == 'function' then
      echo('Installing ' .. server)
      for _, line in ipairs(update(servers_dir)) do
        table.insert(script_lines, line)
      end
      table.insert(script_lines, 'cd ' .. servers_dir)
      echo('')
    elseif generic_installs[update[1]] ~= nil then
      local install = generic_installs[update[1]]

      table.insert(install.servers, server)
      table.insert(install.packages, update[2])
    elseif vim.tbl_islist(update) then
      for _, up in ipairs(update) do
        handle_install(server, up)
      end
    else
      print('Invalid update function for ' .. server)
    end
  end

  for _, server in ipairs(server_list) do
    local ok, update = pcall(require, 'lsp.update.' .. server)

    if not ok then
      print('No update function for ' .. server)
    else
      handle_install(server, update)
    end
  end

  for _, info in pairs(generic_installs) do
    if not vim.tbl_isempty(info.packages) then
      echo(string.format('echo "Installing packages for %s"', table.concat(info.servers, ', ')))
      table.insert(script_lines, string.format('%s %s', info.cmd, table.concat(info.packages, ' ')))
      echo('')
    end
  end

  local script = table.concat(script_lines, '\n')

  cmd('LspStop')
  os.execute('mkdir -p ' .. servers_dir)
  cmd('new | startinsert')
  fn.termopen({ 'sh', '-c', script }, { cwd = servers_dir })
  cmd('LspStart')
end

return {
  update_servers = function(server_names)
    update_servers(vim.split(server_names, ' '))
  end,
  update_all_servers = function()
    update_servers(require('lsp.servers'))
  end,
}
