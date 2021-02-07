-- General Settings {{{
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
      underline = true,
    }
  }
)

vim.fn.sign_define("LspDiagnosticsSignError", {text = "", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "🛈", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "!", texthl = "LspDiagnosticsSignHint"})
-- }}}

-- Completion {{{
vim.o.completeopt = 'menu,menuone,noselect'
require'compe'.setup {
  enabled = true;
  min_length = 3;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    snippets_nvim = true;
  }
}

local compe_opts = { silent = true, expr = true, noremap = true }
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete', compe_opts)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', compe_opts)
vim.api.nvim_set_keymap('i', '<Tab>', 'compe#confirm("<Tab>")', compe_opts)
-- }}}

-- Status {{{
local lsp_status = require'lsp-status'
lsp_status.register_progress()
-- }}}

-- Lightbulb {{{
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- }}}

-- Language Servers {{{
local lspconfig = require'lspconfig'
local custom_attach = require'lsp-attach'.custom_attach
local capabilities = require'lsp-attach'.get_capabilities()

-- tsserver {{{
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    custom_attach(client, bufnr)
  end
}
-- }}}

-- jdtls {{{
vim.api.nvim_exec([[
  augroup java_lsp
    au!
    au FileType java lua require'jdtls-setup'.initialize_client()
  augroup end
]], true)
-- }}}

-- diagnosticls {{{
local eslint = {
  command = './node_modules/.bin/eslint',
  rootPatterns = {'.git'},
  debounce = 100,
  args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
  sourceName = 'eslint',
  parseJson = {
    errorsRoot = '[0].messages',
    line = 'line',
    column = 'column',
    endLine = 'endLine',
    endColumn = 'endColumn',
    message = '[eslint] ${message} [${ruleId}]',
    security = 'severity'
  },
  securities = {
    [2] = 'error',
    [1] = 'warning'
  }
}

lspconfig.diagnosticls.setup{
  capabilities = capabilities,
  on_attach = custom_attach,
  filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  init_options = {
    linters = {eslint = eslint},
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    }
  }
}
-- }}}
-- }}}
