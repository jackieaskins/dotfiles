return function(client, bufnr)
  local function bsk(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function bso(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  require('lsp_signature').on_attach({
    bind = true, -- Required for border
    handler_opts = { border = 'single' },
    hint_enable = false,
    floating_window = false,
  })

  if client.supports_method('textDocument/codeAction') then
    require('utils').augroup_buf('lightbulb', {
      { 'CursorHold,CursorHoldI', '<buffer>', "lua require('nvim-lightbulb').update_lightbulb()" },
    })
  end

  bso('omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bsk('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bsk('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  bsk('n', 'g?', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "single"})<CR>', opts)
  bsk('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = "single"}})<CR>', opts)
  bsk('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = "single"}})<CR>', opts)

  bsk('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  bsk('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bsk('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bsk('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end
