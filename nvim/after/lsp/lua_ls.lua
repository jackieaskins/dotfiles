---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
      hint = { arrayIndex = 'Disable', enable = true },
      workspace = { checkThirdParty = false },
    },
  },
}
