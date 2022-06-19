return function(config)
  local lua_dev_config = require('lua-dev').setup({
    library = {
      vimruntime = true,
      types = true,
      -- Limiting plugins to reduce server startup time
      plugins = {
        'neotest',
        'nvim-treesitter',
        'onenord',
        'plenary.nvim',
      },
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
        },
      },
    },
  })

  local hammerspoon_libraries = {
    '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs',
    '~/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
  }

  for _, lib in ipairs(hammerspoon_libraries) do
    table.insert(lua_dev_config.settings.Lua.workspace.library, lib)
  end

  return lua_dev_config
end
