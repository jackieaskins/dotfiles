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
