local fn = vim.fn

local M = {}

local system_name
local install_path
if fn.has('mac') == 1 then
  system_name = 'macOS'
  install_path = 'compile/ninja/macos.ninja'
elseif fn.has('unix') == 1 then
  system_name = 'Linux'
  install_path = 'compile/ninja/linux.ninja'
elseif fn.has('win32') == 1 then
  system_name = 'Windows'
  install_path = 'compile/ninja/mingw.ninja'
else
  print('Unsupported system for sumneko')
end

local sumneko_root_path = fn.stdpath('data') .. '/lsp-servers/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

function M.configure(config)
  local luaDevConfig = require('lua-dev').setup {}

  luaDevConfig.capabilities = config.capabilities
  luaDevConfig.on_attach = config.on_attach
  luaDevConfig.cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'}

  return luaDevConfig
end

-- TODO: This assumes ninja is already installed
function M.update()
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

return M
