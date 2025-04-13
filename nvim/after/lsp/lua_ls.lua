---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
      hint = { arrayIndex = 'Disable', enable = true },
      workspace = { checkThirdParty = false },
    },
  },
}
