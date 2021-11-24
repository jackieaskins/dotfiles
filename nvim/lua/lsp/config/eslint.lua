return function(config)
  config.root_dir = require('lspconfig').util.root_pattern('./node_modules/eslint')
  config.on_attach = function(client, bufnr)
    require('lsp.attach')(client, bufnr)

    require('utils').map('n', '<leader>ef', '<Cmd>EslintFixAll<CR>')
  end
  config.flags = {}

  return config
end
