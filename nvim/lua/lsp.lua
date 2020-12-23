local lspconfig = require'lspconfig'
local completion = require'completion'

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
  completion.on_attach(client)
  lsp_status.on_attach(client)
end

lspconfig.tsserver.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach
}

lspconfig.sumneko_lua.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach
}

lspconfig.diagnosticls.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  init_options = {
    linters = {
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = { '.git' },
        debounce = 100,
        args = {
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json',
        },
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
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    }
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
    }
  }
)
