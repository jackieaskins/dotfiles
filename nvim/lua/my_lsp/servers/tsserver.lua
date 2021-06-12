local ts_utils = require 'nvim-lsp-ts-utils'

local M = {}

function M.configure(config)
  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require'my_lsp/attach'.custom_attach(client, bufnr)

    ts_utils.setup {
      eslint_enable_code_actions = true,
      eslint_enable_diagnostics = true,
      eslint_enable_disable_comments = true,
      eslint_bin = 'eslint_d',

      enable_import_on_completion = true,

      update_imports_on_move = true,
      require_confirmation_on_move = true,
    }
  end
  return config
end

return M
