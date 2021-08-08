local fn = vim.fn

local system_name
if fn.has('mac') == 1 then
  system_name = 'macOS'
elseif fn.has('unix') == 1 then
  system_name = 'Linux'
elseif fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end

local sumneko_root_path = fn.stdpath('data') .. '/lsp-servers/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

return function(config)
  local luaDevConfig = require('lua-dev').setup({
    lspconfig = {
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    },
  })

  return luaDevConfig
end
