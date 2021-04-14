local M = {}

function M.custom_attach(_, bufnr)
  local function bsk(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function bso(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = {noremap=true, silent=true}

  require'lsp_signature'.on_attach()

  bso('omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bsk('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bsk('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bsk('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  bsk('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bsk('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bsk('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  bsk('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bsk('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  bsk('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "single"})<CR>', opts)
  bsk('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = "single"}})<CR>', opts)
  bsk('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = "single"}})<CR>', opts)

  bsk('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  bsk('n', '<leader>sw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  bsk('n', '<leader>sd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

  bsk('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bsk('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bsk('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

return M
