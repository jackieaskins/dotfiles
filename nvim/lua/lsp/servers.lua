---@class ClientConfig: lspconfig.Config
---@field root_dir string | function

---@class LspServer
---@field config? fun(config: ClientConfig): ClientConfig
---@field display? string
---@field install? InstallCommand
---@field skip_lspconfig? boolean

---@type table<string, LspServer>
local servers = {
  clangd = { install = { 'brew', 'llvm' } },
  cssls = { install = { 'npm', 'vscode-langservers-extracted' } },
  denols = require('lsp.servers.denols'),
  emmet_language_server = require('lsp.servers.emmet_language_server'),
  eslint = require('lsp.servers.eslint'),
  gdscript = { install = { 'brew', 'godot' } },
  ['ghostty-ls'] = require('lsp.servers.ghostty-ls'),
  gopls = { install = { 'go', 'golang.org/x/tools/gopls@latest' } },
  graphql = require('lsp.servers.graphql'),
  html = require('lsp.servers.html'),
  jdtls = require('lsp.servers.jdtls'),
  jsonls = require('lsp.servers.jsonls'),
  lua_ls = require('lsp.servers.lua_ls'),
  omnisharp = require('lsp.servers.omnisharp'),
  pyright = { install = { 'npm', 'pyright' } },
  ruby_lsp = { install = { 'gem', 'ruby-lsp' } },
  solargraph = { install = { 'gem', 'solargraph' } },
  sourcekit = require('lsp.servers.sourcekit'),
  svelte = require('lsp.servers.svelte'),
  tailwindcss = require('lsp.servers.tailwindcss'),
  taplo = require('lsp.servers.taplo'),
  ['typescript-tools'] = require('lsp.servers.typescript-tools'),
  vimls = { install = { 'npm', 'vim-language-server' } },
  yamlls = { install = { 'npm', 'yaml-language-server' } },
}

for server_name, config in pairs(MY_CONFIG.additional_servers) do
  servers[server_name] = config.server
end

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
require('installer').register('lsp', install_cmds, vim.fn.stdpath('data') .. '/lsp-servers')

return supported_servers

-- vim:foldmethod=marker foldlevel=0
