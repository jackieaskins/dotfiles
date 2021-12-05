local fn = vim.fn

local system_name
local separator = '/'
if fn.has('mac') == 1 then
  system_name = 'macOS'
elseif fn.has('unix') == 1 then
  system_name = 'Linux'
elseif fn.has('win32') == 1 then
  system_name = 'Windows'
  separator = '\\'
else
  print('Unsupported system for sumneko')
end

local lua_language_server_path = table.concat({
  fn.stdpath('data'),
  'lsp-servers',
  'lua-language-server',
  'bin',
  system_name,
  'lua-language-server',
}, separator)

return function(config)
  local luaDevConfig = require('lua-dev').setup({
    lspconfig = {
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      cmd = { lua_language_server_path },
      settings = { Lua = { diagnostics = { globals = { 'packer_plugins' } } } },
    },
  })

  return luaDevConfig
end
