return {
  'artemave/workspace-diagnostics.nvim',
  lazy = true,
  init = function()
    require('utils').augroup('workspace_diagnostics', {
      {
        'LspAttach',
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('workspace-diagnostics').populate_workspace_diagnostics(client, args.buf)
        end,
      },
    })
  end,
}
