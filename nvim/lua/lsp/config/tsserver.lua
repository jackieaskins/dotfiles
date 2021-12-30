return function(config)
  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    require('lsp.attach')(client, bufnr)

    require('nvim-lsp-ts-utils').setup({
      enable_import_on_completion = true,

      update_imports_on_move = true,
      require_confirmation_on_move = true,

      eslint_enable_code_actions = false,
      eslint_enable_disable_comments = false,
      eslint_enable_diagnostics = false,
    })

    local function bsk(mode, lhs, rhs)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
    end
    bsk('n', '<leader>oi', '<cmd>TSLspOrganize<CR>')
    bsk('n', '<leader>ia', '<cmd>TSLspImportAll<CR>')
    bsk('n', '<leader>ic', '<cmd>TSLspImportCurrent<CR>')
    bsk('n', '<leader>rf', '<cmd>TSLspRenameFile<CR>')
  end

  return config
end
