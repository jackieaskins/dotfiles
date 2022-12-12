return function(_, bufnr)
  local map = require('utils').map

  local function bsk(mode, lhs, rhs, opts)
    ---@type table|nil
    local options = { buffer = bufnr }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    map(mode, lhs, rhs, options)
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  bsk('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  bsk('n', 'gr', '<cmd>Telescope lsp_references include_declaration=false<CR>')

  bsk('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  bsk({ 'i', 'n' }, '<C-S>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help' })

  bsk('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'vim.lsp.buf.rename' })
  bsk('n', '<leader>bf', function()
    vim.lsp.buf.format({ async = true })
  end, { desc = 'vim.lsp.buf.format' })

  bsk('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action' })
  bsk('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.range_code_action' })

  bsk('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
  bsk('n', '<leader>sd', '<cmd>Telescope lsp_document_symbols symbols=constant,function,method<CR>')
  bsk('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'vim.lsp.buf.add_workspace_folder' })
  bsk('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'vim.lsp.buf.remove_workspace_folder' })
  bsk('n', '<leader>wl', '<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>')
end
