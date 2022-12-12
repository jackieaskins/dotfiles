require('neodev').setup({
  library = {
    plugins = {
      'catppuccin',
      'neotest',
      'nvim-cmp',
      'nvim-treesitter',
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
        checkThirdParty = false,
        library = {
          '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs',
          '~/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
        },
      },
    },
  }

  return config
end
