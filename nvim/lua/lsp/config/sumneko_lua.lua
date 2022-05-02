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
            globals = { 'hs', 'packer_plugins' },
          },
          workspace = {
            library = {
              ['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
              ['~/.hammerspoon/Spoons/EmmyLua.spoon/annotations'] = true,
            },
          },
        },
      },
    },
  })

  return luaDevConfig
end
