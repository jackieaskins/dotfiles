---@type LazySpec
return {
  'artemave/workspace-diagnostics.nvim',
  keys = {
    {
      '<leader>wD',
      function()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
        end
      end,
    },
  },
}
