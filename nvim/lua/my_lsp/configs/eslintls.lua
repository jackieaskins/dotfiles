local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

if not configs.eslintls then
  configs.eslintls = {
    default_config = {
      cmd = {'eslint-ls', '--stdio'},
      filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
      root_dir = util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.yaml',
                                   '.eslintignore', '.git'),
    },
  }
end
