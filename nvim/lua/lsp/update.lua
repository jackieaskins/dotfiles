local function install_jdtls(servers_dir)
  local install_dir = servers_dir .. '/eclipse.jdt.ls'
  local zip_file = 'jdt-language-server-latest.tar.gz'

  return {
    'rm -rf ' .. install_dir,
    'mkdir ' .. install_dir,
    'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
    'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
    'rm ' .. zip_file,
  }
end

local function install_sumneko_lua()
  local install_path
  if vim.fn.has('mac') == 1 then
    install_path = 'compile/ninja/macos.ninja'
  elseif vim.fn.has('unix') == 1 then
    install_path = 'compile/ninja/linux.ninja'
  else
    print('Unsupported system for sumneko')
  end

  local language_server = 'lua-language-server'

  return {
    'rm -rf ' .. language_server,
    'git clone https://github.com/sumneko/' .. language_server,
    'cd ' .. language_server,
    'git submodule update --init --recursive',
    'cd 3rd/luamake',
    'ninja -f ' .. install_path,
    'cd ../..',
    './3rd/luamake/luamake rebuild',
  }
end

local install_commands = {
  eslint = { 'npm', 'vscode-langservers-extracted' },
  graphql = { 'npm', 'graphql-language-service-cli' },
  html = { 'npm', 'vscode-langservers-extracted' },
  jdtls = install_jdtls,
  jsonls = { 'npm', 'vscode-langservers-extracted' },
  pyright = { 'npm', 'pyright' },
  solargraph = { 'gem', 'solargraph' },
  sumneko_lua = install_sumneko_lua,
  tsserver = { 'npm', 'typescript typescript-language-server' },
  vimls = { 'npm', 'vim-language-server' },
  yamlls = { 'npm', 'yaml-language-server' },
}

local function get_active_server_names()
  return vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.buf_get_clients(0))
end

local function update_servers(server_list)
  server_list = server_list or get_active_server_names()

  local server_commands = {}
  for _, server in ipairs(server_list) do
    server_commands[server] = install_commands[server]
  end

  require('installer').install(server_commands, vim.fn.stdpath('data') .. '/lsp-servers')
end

return {
  update_servers = function(server_names)
    update_servers(server_names and vim.split(server_names, ' ') or nil)
  end,
  update_all_servers = function()
    update_servers(require('lsp.servers'))
  end,
}
