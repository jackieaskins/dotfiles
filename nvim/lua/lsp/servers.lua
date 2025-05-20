---@class LspServer
---@field display? string
---@field install? InstallCommand
---@field skip_lspconfig? boolean

local installer = require('installer')

---@type table<string, LspServer>
local servers = {
  clangd = { install = { 'brew', 'llvm' } },
  cssls = { install = { 'npm', 'vscode-langservers-extracted' } },
  denols = { install = { 'brew', 'deno' } },
  emmet_language_server = {
    display = 'emmet-ls',
    install = { 'npm', '@olrtg/emmet-language-server' },
  },
  eslint = { install = { 'npm', 'vscode-langservers-extracted' } },
  gopls = { install = { 'go', 'golang.org/x/tools/gopls@latest' } },
  graphql = { install = { 'npm', 'graphql-language-service-cli' } },
  html = { install = { 'npm', 'vscode-langservers-extracted' } },
  jdtls = {
    install = function(servers_dir)
      local install_dir = servers_dir .. '/eclipse.jdt.ls'
      local zip_file = 'jdt-language-server-latest.tar.gz'

      return {
        'rm -rf ' .. install_dir,
        'mkdir ' .. install_dir,
        'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
        'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
        'rm ' .. zip_file,
        'cd ' .. install_dir .. '/plugins',
        'wget https://projectlombok.org/downloads/lombok.jar',
      }
    end,
    skip_lspconfig = true,
  },
  jsonls = { install = { 'npm', 'vscode-langservers-extracted' } },
  lua_ls = { install = { 'brew', 'lua-language-server' } },
  pyright = { install = { 'npm', 'pyright' } },
  ruby_lsp = { install = { 'gem', 'ruby-lsp' } },
  solargraph = { install = { 'gem', 'solargraph' } },
  sourcekit = {},
  svelte = { install = { 'npm', 'svelte-language-server' } },
  taplo = {
    install = function()
      return { 'cargo install --features lsp --locked taplo-cli' }
    end,
  },
  ts_query_ls = {
    install = installer.github_install('ribru17', 'ts_query_ls', 'ts_query_ls-aarch64-apple-darwin.tar.gz'),
  },
  ['typescript-tools'] = {
    display = 'ts-tools',
    install = { 'npm', 'typescript typescript-svelte-plugin typescript-styled-plugin' },
    skip_lspconfig = true,
  },
  vimls = { install = { 'npm', 'vim-language-server' } },
  yamlls = { install = { 'npm', 'yaml-language-server' } },
}

local supported_servers = {}
if MY_CONFIG.supported_servers then
  for _, server_name in ipairs(MY_CONFIG.supported_servers) do
    if servers[server_name] then
      supported_servers[server_name] = servers[server_name]
    end
  end
else
  supported_servers = servers
end

local install_cmds = {}
for server, data in pairs(supported_servers) do
  if data.install then
    install_cmds[server] = data.install
  end
end
installer.register('lsp', install_cmds, vim.fn.stdpath('data') .. '/lsp-servers')

return supported_servers
