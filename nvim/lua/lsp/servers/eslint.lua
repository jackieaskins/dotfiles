---@type LspServer
return {
  config = function(config)
    config.root_dir = require('lspconfig').util.root_pattern('./node_modules/eslint')
    config.on_attach = function(_, bufnr)
      require('utils').buffer_map(bufnr)('n', '<leader>ef', vim.cmd.EslintFixAll)
    end
    config.handlers = {
      ['textDocument/publishDiagnostics'] = function(err, result, ctx, conf)
        for _, diagnostic in ipairs(result.diagnostics) do
          diagnostic.severity = 4
        end

        return vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, conf)
      end,
    }

    return config
  end,
  install = { 'npm', 'vscode-langservers-extracted' },
}
