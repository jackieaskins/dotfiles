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

    local function bsk(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }
    bsk('n', '<leader>oi', '<cmd>TSLspOrganize<CR>', opts)

    -- TSLspImportAll is broken
    bsk('n', '<leader>ia', '<cmd>lua require("nvim-lsp-ts-utils.import-all")(vim.api.nvim_get_current_buf())<CR>', opts)

    bsk('n', '<leader>ic', '<cmd>TSLspImportCurrent<CR>', opts)
    bsk('n', '<leader>rf', '<cmd>TSLspRenameFile<CR>', opts)
  end

  return config
end
