return function(client, bufnr)
  local function bsk(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  local function bso(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  if client.supports_method('textDocument/codeAction') then
    require('utils').augroup_buf('lightbulb', {
      {
        'CursorHold,CursorHoldI',
        '<buffer>',
        'lua require("nvim-lightbulb").update_lightbulb({ sign = { priority = 50 } })',
      },
    })
  end

  bso('omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  bsk('i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  bsk('n', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bsk('n', 'g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>')
  bsk('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  bsk('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>')

  bsk('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  bsk('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bsk('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bsk('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
end
