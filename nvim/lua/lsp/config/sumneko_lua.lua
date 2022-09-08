require('lua-dev').setup({
  library = {
    plugins = {
      'neotest',
      'nvim-cmp',
      'nvim-treesitter',
      'onenord',
      'plenary.nvim',
    },
  },
})

return function(config)
  config.settings = {
    Lua = {
      completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
      diagnostics = {
        globals = { 'hs', 'packer_plugins', 'vim' },
      },
      workspace = {
        library = {
          '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs',
          '~/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
        },
      },
    },
  }

  return config
end
