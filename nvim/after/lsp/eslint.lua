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
  on_attach = function(client, bufnr)
    require('utils').buffer_map(bufnr)('n', '<leader>ef', function()
      client:exec_cmd({
        title = 'Fix all Eslint errors for current buffer',
        command = 'eslint.applyAllFixes',
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, { bufnr = bufnr })
    end)
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
