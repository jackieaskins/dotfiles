return {
  config = function(config)
    config.settings = {
      Lua = {
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        diagnostics = { globals = { 'hs', 'vim' } },
        workspace = { checkThirdParty = false },
      },
    }

    return config
  end,
  install = { 'brew', 'lua-language-server' },
}
