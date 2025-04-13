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
  on_attach = function(client, bufnr)
    require('lsp.utils').setup_auto_close_tag(client, bufnr, 'html/tag')

    require('utils').augroup('svelte_tsjschanges', {
      {
        { 'BufWritePost' },
        pattern = { '*.js', '*.ts' },
        callback = function(args)
          client:notify('$/onDidChangeTsOrJsFile', { uri = args.match })
        end,
      },
    })
  end,
}
