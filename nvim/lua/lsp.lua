local lspconfig = require'lspconfig'

local lsp_status = require'lsp-status'
lsp_status.register_progress()

lsp_status.config({
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '🛈',
  indicator_hint = '!',
  indicator_ok = '',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})

local custom_attach = function(client)
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  lsp_status.on_attach(client)
end

lspconfig.tsserver.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach
}

lspconfig.sumneko_lua.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim" },
      }
    }
  }
}

local eslint = {
  command = './node_modules/.bin/eslint',
  rootPatterns = { '.git' },
  debounce = 100,
  args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
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
  args = { '--stdin', '--stdin-filepath', '%filepath' },
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
  }
}

lspconfig.diagnosticls.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  init_options = {
    linters = { eslint = eslint },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    },
    formatters = { prettier = prettier },
    formatFiletypes = {
      javascript = 'prettier',
      typescript = 'prettier',
      javascriptreact = 'prettier',
      typescriptreact = 'prettier'
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
    }
  }
)
