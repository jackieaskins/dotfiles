local function install_jdtls(servers_dir)
  local install_dir = servers_dir .. '/eclipse.jdt.ls'
  local zip_file = 'jdt-language-server-latest.tar.gz'

  return {
    'rm -rf ' .. install_dir,
    'mkdir ' .. install_dir,
    'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
    'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
    'rm ' .. zip_file,
    'cd ' .. install_dir,
    'wget https://projectlombok.org/downloads/lombok.jar',
  }
end

local install_commands = {
  cssls = { 'npm', 'vscode-langservers-extracted' },
  emmet_ls = { 'npm', 'emmet-ls' },
  eslint = { 'npm', 'vscode-langservers-extracted' },
  gopls = { 'go', 'golang.org/x/tools/gopls@latest' },
  graphql = { 'npm', 'graphql-language-service-cli' },
  html = { 'npm', 'vscode-langservers-extracted' },
  jdtls = install_jdtls,
  jsonls = { 'npm', 'vscode-langservers-extracted' },
  pyright = { 'npm', 'pyright' },
  solargraph = { 'gem', 'solargraph' },
  sumneko_lua = { 'brew', 'lua-language-server' },
  tsserver = { 'npm', 'typescript typescript-language-server' },
  vimls = { 'npm', 'vim-language-server' },
  yamlls = { 'npm', 'yaml-language-server' },
}

local all_install_commands = vim.tbl_extend('force', install_commands, vim.g.additional_server_commands or {})

local supported_install_commands = {}
if vim.g.supported_servers then
  for _, server_name in ipairs(vim.g.supported_servers) do
    supported_install_commands[server_name] = all_install_commands[server_name]
  end
else
  supported_install_commands = all_install_commands
end

return {
  server_names = vim.tbl_keys(supported_install_commands),
  install_commands = supported_install_commands,
}
