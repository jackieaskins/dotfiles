local function publish_diagnostics_handler(err, result, ctx, config)
  for _, diagnostic in ipairs(result.diagnostics) do
    diagnostic.severity = 4
  end

  return vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
end

return function(config)
  config.filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'svelte',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  }
  config.root_dir = require('lspconfig').util.root_pattern('./node_modules/eslint')
  config.on_attach = function(client, bufnr)
    require('lsp.attach')(client, bufnr)

    require('utils').map('n', '<leader>ef', vim.cmd.EslintFixAll)
  end
  config.handlers = {
    ['textDocument/publishDiagnostics'] = publish_diagnostics_handler,
  }

  return config
end
