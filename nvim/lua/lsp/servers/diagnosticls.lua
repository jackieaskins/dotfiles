local M = {}

function M.configure(config)
  local lspconfig = require'lspconfig'

  local eslint = {
    command = 'eslint_d',
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

  config.root_dir = lspconfig.util.root_pattern('.git')
  config.filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  }
  config.init_options = {
    linters = {eslint = eslint},
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    }
  }

  return config
end

return M
