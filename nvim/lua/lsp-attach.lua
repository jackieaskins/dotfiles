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

  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>sy', '<cmd>lua vim.document_symbol()<CR>', opts)

  vim.api.nvim_exec([[
    hi link LspReferenceText Visual
    hi link LspReferenceRead Visual
    hi link LspReferenceWrite Visual

    augroup document_hightlight
      autocmd!
      autocmd CursorHold  * lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved * lua vim.lsp.buf.clear_references()
      autocmd CursorMovedI * lua vim.lsp.buf.clear_references()
    augroup END
  ]], true)

  if client.name == 'jdtls' then
    buf_set_keymap('n', '<leader>ca', "<cmd>lua require('jdtls').code_action()<CR>", opts)
    buf_set_keymap('v', '<leader>ca', "<esc><cmd>lua require('jdtls').code_action(true)<CR>", opts)
  else
    buf_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
    buf_set_keymap('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', opts)
  end

  buf_set_keymap('i', '<C-k>', "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>", opts)
  buf_set_keymap('n', '<C-k>', "<cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>", opts)

  buf_set_keymap('n', 'K', "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>", opts)
  buf_set_keymap('n', '<C-f>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<C-b>', "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>", opts)

  buf_set_keymap('n', 'gd', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)
  buf_set_keymap('n', 'gh', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
  buf_set_keymap('n', 'gr', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)

  buf_set_keymap('n', '<leader>ld', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  buf_set_keymap('n', '[g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  buf_set_keymap('n', ']g', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

  buf_set_keymap('n', '<leader>rn', "<cmd>lua require'lspsaga.rename'.rename()<CR>", opts)

  vim.cmd [[autocmd CursorHold * Lspsaga show_line_diagnostics]]
end

return M
