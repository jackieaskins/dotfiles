---@type LspServer
return {
  install = { 'npm', 'svelte-language-server' },
  config = function(config)
    config.init_options = {
      configuration = {
        svelte = {
          plugin = {
            svelte = {
              defaultScriptLanguage = 'ts',
            },
          },
        },
      },
    }

    config.on_attach = function(client, bufnr)
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
    end

    return config
  end,
}
