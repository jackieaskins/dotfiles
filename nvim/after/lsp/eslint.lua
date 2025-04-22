---@type vim.lsp.Config
return {
  root_markers = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    'eslint.config.mts',
    'eslint.config.cts',
    './node_modules/eslint',
  },
  on_attach = function(_, bufnr)
    require('utils').buffer_map(bufnr)('n', '<leader>ef', vim.cmd.EslintFixAll)
  end,
  handlers = {
    ['textDocument/diagnostic'] = function(err, result, ctx)
      if result and result.items then
        for _, item in ipairs(result.items) do
          item.severity = 4
        end
      end

      return vim.lsp.handlers['textDocument/diagnostic'](err, result, ctx)
    end,
  },
}
