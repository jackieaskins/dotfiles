local fn = vim.fn

local M = {}

local system_name
if fn.has("mac") == 1 then
  system_name = "macOS"
elseif fn.has("unix") == 1 then
  system_name = "Linux"
elseif fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = fn.stdpath('data') .. '/lsp-servers/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

-- TODO: Better map K
function M.configure(config)
  config.cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"}
  config.settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [fn.expand('$VIMRUNTIME/lua')] = true,
          [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  }

  return config
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
    'compile/install.sh',
    'cd ../..',
    './3rd/luamake/luamake rebuild'
  }
end

return M
