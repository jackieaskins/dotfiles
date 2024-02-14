---@class LspServer
---@field config function?
---@field display string?
---@field install InstallCommand
---@field skip_lspconfig boolean?

---@type table<string, LspServer>
local servers = {
  cssls = { install = { 'npm', 'vscode-langservers-extracted' } },
  emmet_language_server = require('lsp.servers.emmet_language_server'),
  eslint = require('lsp.servers.eslint'),
  gdscript = { install = { 'brew', 'godot' } },
  gopls = { install = { 'go', 'golang.org/x/tools/gopls@latest' } },
  graphql = require('lsp.servers.graphql'),
  html = require('lsp.servers.html'),
  jdtls = require('lsp.servers.jdtls'),
  jsonls = require('lsp.servers.jsonls'),
  omnisharp = require('lsp.servers.omnisharp'),
  pyright = { install = { 'npm', 'pyright' } },
  solargraph = { install = { 'gem', 'solargraph' } },
  lua_ls = require('lsp.servers.lua_ls'),
  svelte = require('lsp.servers.svelte'),
  tailwindcss = require('lsp.servers.tailwindcss'),
  ['typescript-tools'] = require('lsp.servers.typescript-tools'),
  vimls = { install = { 'npm', 'vim-language-server' } },
  yamlls = { install = { 'npm', 'yaml-language-server' } },
}

local all_servers = vim.tbl_extend('force', servers, vim.g.additional_server_commands or {})

local supported_servers = {}
if vim.g.supported_servers then
  for _, server_name in ipairs(vim.g.supported_servers) do
    if all_servers[server_name] then
      supported_servers[server_name] = all_servers[server_name]
    end
  end
else
  supported_servers = all_servers
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
