return function(client, bufnr)
  local utils = require('utils')
  local augroup, map = utils.augroup, utils.map

  local function bsk(mode, lhs, rhs, opts)
    local options = { buffer = bufnr }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    map(mode, lhs, rhs, options)
  end
  local function bso(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  if client.supports_method('textDocument/codeAction') then
    augroup('lightbulb', {
      {
        'CursorHold,CursorHoldI',
        {
          buffer = bufnr,
          callback = require('nvim-lightbulb').update_lightbulb,
        },
      },
    })
  end

  bso('omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  bsk('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  bsk('n', 'gr', '<cmd>Telescope lsp_references include_declaration=false<CR>')

  bsk('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  bsk({ 'i', 'n' }, '<C-S>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help' })

  bsk('n', '<leader>dg', '<cmd>Telescope diagnostics<CR>')
  bsk('n', 'g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>')
  bsk('n', '[g', vim.diagnostic.goto_prev, { desc = 'vim.diagnostic.goto_prev' })
  bsk('n', ']g', vim.diagnostic.goto_next, { desc = 'vim.diagnostic.goto_next' })
  bsk('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>')
  bsk('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>')

  bsk('n', '<leader>bf', vim.lsp.buf.formatting, { desc = 'vim.lsp.buf.formatting' })

  bsk('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action' })
  bsk('x', '<leader>ca', vim.lsp.buf.range_code_action, { desc = 'vim.lsp.buf.range_code_action' })

  bsk('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
  bsk('n', '<leader>sd', '<cmd>Telescope lsp_document_symbols<CR>')
  bsk('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'vim.lsp.buf.add_workspace_folder' })
  bsk('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'vim.lsp.buf.remove_workspace_folder' })
  bsk('n', '<leader>wl', '<cmd>lua Print(vim.lsp.buf.list_workspace_folders())<CR>')
end
