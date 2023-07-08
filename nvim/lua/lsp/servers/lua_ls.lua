return {
  config = function(config)
    config.settings = {
      Lua = {
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        hint = { arrayIndex = 'Disable', enable = true },
        workspace = { checkThirdParty = false },
      },
    }

    return config
  end,
  install = { 'brew', 'lua-language-server' },
}
