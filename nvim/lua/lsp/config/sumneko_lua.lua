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
          completion = {
            keywordSnippet = 'Replace',
            callSnippet = 'Replace',
          },
          diagnostics = {
            globals = { 'hs', 'packer_plugins', 'vim' },
          },
          workspace = {
            library = {
              '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/',
              '~/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
            },
          },
        },
      },
    },
  })

  return luaDevConfig
end
