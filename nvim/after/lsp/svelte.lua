---@type vim.lsp.Config
return {
  init_options = {
    configuration = {
      svelte = {
        plugin = {
          svelte = {
            defaultScriptLanguage = 'ts',
          },
        },
      },
    },
  },
}
