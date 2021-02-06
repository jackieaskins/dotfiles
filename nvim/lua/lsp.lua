-- LSP Options & Mappings {{{
local set_lsp_options_mappings = function(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

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
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
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

-- Status {{{
local lsp_status = require'lsp-status'
lsp_status.register_progress()
-- }}}

-- Lightbulb {{{
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- }}}

-- Language Servers {{{
local custom_attach = function(client, bufnr)
  set_lsp_options_mappings(bufnr)
  lsp_status.on_attach(client)
end

-- tsserver
local lspconfig = require'lspconfig'
lspconfig.tsserver.setup {
  capabilities = lsp_status.capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    custom_attach(client, bufnr)
  end
}

-- diagnosticls
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

local prettier = {
  command = './node_modules/.bin/prettier',
  args = {'--stdin', '--stdin-filepath', '%filepath'},
  rootPatterns = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.toml',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    'prettier.config.js',
    'prettier.config.cjs',
    '.git'
  }
}

lspconfig.diagnosticls.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach,
  on_attach = function(client, bufnr)
    vim.api.nvim_exec([[
      augroup FormatAutogroup
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
      augroup END
    ]], true)
    custom_attach(client, bufnr)
  end,
  filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  init_options = {
    linters = {eslint = eslint},
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    },
    formatters = {prettier = prettier},
    formatFiletypes = {
      javascript = 'prettier',
      typescript = 'prettier',
      javascriptreact = 'prettier',
      typescriptreact = 'prettier'
    },
  },
}
-- }}}
