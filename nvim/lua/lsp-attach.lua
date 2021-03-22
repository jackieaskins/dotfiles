local M = {}

M.get_capabilities = function()
  local capabilities = require'lsp-status'.capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

M.custom_attach = function(client, bufnr)
  require'lsp-status'.on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  buf_set_keymap('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap('v', '<leader>ca', "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

  buf_set_keymap('i', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap('n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  buf_set_keymap('n', '<leader>ld', "<cmd>lua vim.lsp.show_line_diagnostics()<CR>", opts)
  buf_set_keymap('n', '[g', "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap('n', ']g', "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  buf_set_keymap('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

return M
