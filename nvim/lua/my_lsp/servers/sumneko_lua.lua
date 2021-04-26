local M = {}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand('$HOME/dotfiles/lsp-servers/lua-language-server')
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
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  }

  return config
end

return M
