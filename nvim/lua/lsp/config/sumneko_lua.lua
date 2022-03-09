local fn = vim.fn

local separator = vim.fn.has('win32') == 1 and '\\' or '/'

local lua_language_server_path = table.concat({
  fn.stdpath('data'),
  'lsp-servers',
  'lua-language-server',
  'bin',
  'lua-language-server',
}, separator)

return function(config)
  local luaDevConfig = require('lua-dev').setup({
    library = {
      vimruntime = true,
      types = true,
      plugins = { 'nvim-treesitter', 'plenary.nvim' }, -- Limiting plugins to reduce server startup time
    },
    lspconfig = {
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      cmd = { lua_language_server_path },
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'packer_plugins' },
          },
        },
      },
    },
  })

  return luaDevConfig
end
