local ts_utils = require 'nvim-lsp-ts-utils'

local M = {}

function M.configure(config)
  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require'my_lsp/attach'.custom_attach(client, bufnr)

    ts_utils.setup {
      enable_import_on_completion = true,

      update_imports_on_move = true,
      require_confirmation_on_move = true,
    }

    local opts = {noremap = true, silent = true}
    local function bsk(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    bsk('n', '<leader>oi', '<cmd>TSLspOrganize<CR>', opts)
    bsk('n', '<leader>ia', '<cmd>TSLspImportAll<CR>', opts)
    bsk('n', '<leader>rf', '<cmd>TSLspRenameFile<CR>', opts)
  end
  return config
end

return M
