return {
  config = function(config)
    config.settings = {
      Lua = {
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        diagnostics = { globals = { 'hs', 'vim' } },
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
  end,
  install = { 'brew', 'lua-language-server' },
}
