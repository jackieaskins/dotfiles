---@type LspServer
return {
  config = function(config)
    config.root_dir = require('lspconfig').util.root_pattern(
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json',
      'eslint.config.js',
      './node_modules/eslint'
    )
    config.on_attach = function(_, bufnr)
      require('utils').buffer_map(bufnr)('n', '<leader>ef', vim.cmd.EslintFixAll)
    end
    config.handlers = {
      ['textDocument/diagnostic'] = function(err, result, ctx)
        if result and result.items then
          for _, item in ipairs(result.items) do
            item.severity = 4
          end
        end

        return vim.lsp.handlers['textDocument/diagnostic'](err, result, ctx)
      end,
    }

    return config
  end,
  install = { 'npm', 'vscode-langservers-extracted' },
}
