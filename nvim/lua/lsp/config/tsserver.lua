return function(config)
  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.range_formatting = false

    require('lsp.attach')(client, bufnr)

    require('nvim-lsp-ts-utils').setup({
      enable_import_on_completion = true,

      update_imports_on_move = true,
      require_confirmation_on_move = true,

      eslint_bin = 'eslint_d',
    })

    local function bsk(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }
    bsk('n', '<leader>oi', '<cmd>TSLspOrganize<CR>', opts)
    bsk('n', '<leader>ia', '<cmd>TSLspImportAll<CR>', opts)
    bsk('n', '<leader>rf', '<cmd>TSLspRenameFile<CR>', opts)
  end

  return config
end
