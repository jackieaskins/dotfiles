-- LSP Options & Mappings {{{
local set_lsp_options_mappings = function(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_set_keymap('n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>sy', '<cmd>lua vim.document_symbol()<CR>', opts)

  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end
-- }}}

-- General Settings {{{
local custom_attach = function(client, bufnr)
  set_lsp_options_mappings(bufnr)
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
    }
  }
)
-- }}}

-- Completion {{{
vim.o.completeopt = 'menu,menuone,noselect'
require'compe'.setup {
  enabled = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
  }
}

local compe_opts = { silent = true, expr = true, noremap = true }
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete', compe_opts)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', compe_opts)
vim.api.nvim_set_keymap('i', '<Tab>', 'compe#confirm("<Tab>")', compe_opts)
-- }}}

-- Language Servers {{{
local lspconfig = require'lspconfig'
lspconfig.tsserver.setup{
  -- capabilities = lsp_status.capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    custom_attach(client, bufnr)
  end
}
-- }}}
